import 'package:flutter/material.dart';

import 'bloc.dart';

/** 1
 * BlocProvider is a generic class. The generic type T is scoped to be 
 * an object that implements the Bloc interface. This means that the 
 * provider can only store BLoC objects.
 */
class BlocProvider<T extends Bloc> extends StatefulWidget {
  
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child}): super(key: key);

/** 2
 * The of method allows widgets to retrieve the BlocProvider from a 
 * descendant in the widget tree with the current build context. This is 
 * a very common pattern in Flutter.
 */
static T of <T extends Bloc>(BuildContext ctx) {
  final type = _providerType<BlocProvider<T>>();
  final BlocProvider<T> provider = ctx.ancestorWidgetOfExactType(type);
  return provider.bloc;
}

/** 3
 * This is some trampolining to get a reference to the generic type.
 */
static Type _providerType<T>() => T;

@override
State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  
/** 4
 * The widget’s build method is a passthrough to the widget’s child. 
 * This widget will not render anything.
 */
  @override
  Widget build(BuildContext context) => widget.child;

/** 5
 * Finally, the only reason why the provider inherits from StatefulWidget 
 * is to get access to the dispose method. When this widget is removed 
 * from the tree, Flutter will call the dispose method, which will in turn,
 * close the stream.
 */
  @override
  void dispose() {
    
    // TODO: implement dispose
    widget.bloc.dispose();

    super.dispose();
  }

  





/** 6
 * 
 */
}