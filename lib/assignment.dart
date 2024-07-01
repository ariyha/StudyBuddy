import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studybuddy/navbar.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  final GlobalKey<_AnimatedDropdownState> _dropdownKey =
      GlobalKey<_AnimatedDropdownState>();

  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    var dropdownwidget = AnimatedDropdown<String>(
      key: _dropdownKey,
      items: items,
      value: 'Choose',
      onChanged: (newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
      itemBuilder: (item) => Text(item),
    );
    return Scaffold(
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20), // Button color
          ),
          child: Icon(Icons.add, size: 30),
          onPressed: () {
            setState(() {
              items.add('Item ${items.length + 1}');
            });
            _dropdownKey.currentState?.closeDropdown(); // Add this line
          }),
      bottomNavigationBar: NavBar(),
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedDropdown<String>(
                      key: _dropdownKey,
                      items: items,
                      value: 'Choose',
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      itemBuilder: (item) => Text(item,
                          style: Theme.of(context).primaryTextTheme.labelLarge),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        child: Icon(Icons.add, size: 30),
                        onPressed: () {
                          _dropdownKey.currentState
                              ?.closeDropdown(); // Add this line
                        })
                  ],
                ),
              ]),
              Text("data")
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T value;
  final ValueChanged<T?> onChanged;
  final Widget Function(T) itemBuilder;

  const AnimatedDropdown({
    required Key key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  _AnimatedDropdownState<T> createState() => _AnimatedDropdownState<T>();
}

class _AnimatedDropdownState<T> extends State<AnimatedDropdown<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _controller.forward();
    } else {
      _controller.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    }
  }

  void closeDropdown() {
    if (_overlayEntry != null) {
      _controller.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 8,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 400,
                maxWidth: size.width,
              ),
              child: SizeTransition(
                sizeFactor: _animation,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.items
                          .map((item) => ListTile(
                                title: widget.itemBuilder(item),
                                onTap: () {
                                  widget.onChanged(item);
                                  _toggleDropdown();
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        splashFactory: NoSplash.splashFactory, // This removes the splash effect
        highlightColor: Colors.transparent,
        child: Container(
          width: 200,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.itemBuilder(widget.value),
              Icon(Icons.keyboard_double_arrow_down_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
