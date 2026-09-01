import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Real World Custom Ink Demo', theme: ThemeData.dark(), home: const PlasmaScreen());
  }
}

class PlasmaScreen extends StatelessWidget {
  const PlasmaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplo Produção: PlasmaButton')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Este botão é self-contained (independente).\nEle instancia o seu próprio CustomMaterialInkController\n'
              'sem depender do Widget nativo Material.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            PlasmaButton(
              onPressed: () {
                debugPrint('Botão de plasma tocado!');
              },
              child: const Text('TOCAR AQUI', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class PlasmaButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PlasmaButton({super.key, required this.onPressed, required this.child});

  @override
  State<PlasmaButton> createState() => _PlasmaButtonState();
}

class _PlasmaButtonState extends State<PlasmaButton> with TickerProviderStateMixin {
  late final CustomInkController _inkController;

  @override
  void initState() {
    super.initState();
    // O nosso botão tem o seu próprio motor de renderização interno.
    _inkController = CustomInkController(vsync: this);
  }

  @override
  void dispose() {
    _inkController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    // Acionamos a tinta informando a coordenada do toque
    _PlasmaInkFeature(
      controller: _inkController,
      referenceBox: _inkController.renderBox!,
      position: details.localPosition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(color: Colors.blueGrey.shade900, borderRadius: BorderRadius.circular(12)),
        // O renderizador do nosso controller
        child: CustomInkRenderer(
          controller: _inkController,
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), child: widget.child),
        ),
      ),
    );
  }
}

// =====================================================================
// 2. O Controlador Customizado (Garante que a tinta seja removida sem memory leaks)
// =====================================================================
class CustomInkController extends ChangeNotifier implements MaterialInkController {
  CustomInkController({required this.vsync});

  final List<InkFeature> _features = [];

  @override
  final TickerProvider vsync;

  @override
  Color? color;

  RenderBox? renderBox;

  @override
  void addInkFeature(InkFeature feature) {
    _features.add(feature);
    markNeedsPaint();
  }

  @override
  void removeInkFeature(InkFeature feature) {
    _features.remove(feature);
    markNeedsPaint();
  }

  @override
  void markNeedsPaint() {
    // Como agora NÓS somos o ChangeNotifier, podemos chamar nativamente!
    notifyListeners();
  }
}

// =====================================================================
// 3. A Tinta (Efeito Visual)
// =====================================================================
class _PlasmaInkFeature extends InkFeature {
  _PlasmaInkFeature({required super.controller, required super.referenceBox, required this.position}) {
    controller.addInkFeature(this);
    _animController = AnimationController(vsync: controller.vsync, duration: const Duration(milliseconds: 600))
      ..addListener(() => controller.markNeedsPaint())
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          dispose();
        }
      });
    _animController.forward();
  }

  final Offset position;
  late AnimationController _animController;

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // MÉTODO PÚBLICO CRIADO PARA O NOSSO CONTROLLER CHAMAR SEM AVISOS
  void render(Canvas canvas) {
    paintFeature(canvas, Matrix4.identity());
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final double progress = _animController.value;
    final double radius = progress * 150.0;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0 * (1 - progress)
      ..color = Colors.cyanAccent.withValues(alpha: 1 - progress);

    final Offset origin = MatrixUtils.transformPoint(transform, position);
    canvas.drawCircle(origin, radius, paint);
  }
}

class CustomInkRenderer extends SingleChildRenderObjectWidget {
  final CustomInkController controller;

  const CustomInkRenderer({super.key, required this.controller, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderBox = RenderCustomInk(controller: controller);
    controller.renderBox = renderBox;
    return renderBox;
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomInk renderObject) {
    renderObject.controller = controller;
    controller.renderBox = renderObject;
  }
}

class RenderCustomInk extends RenderProxyBox {
  RenderCustomInk({required this._controller});

  CustomInkController _controller;
  CustomInkController get controller => _controller;
  set controller(CustomInkController value) {
    if (_controller == value) return;
    _controller.removeListener(markNeedsPaint);
    _controller = value;
    _controller.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _controller.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _controller.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    if (_controller._features.isNotEmpty) {
      final Canvas canvas = context.canvas;
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.clipRect(Offset.zero & size);

      for (final feature in _controller._features) {
        if (feature is _PlasmaInkFeature) {
          // Chamamos o método público, zero linter warnings!
          feature.render(canvas);
        }
      }
      canvas.restore();
    }
  }
}
