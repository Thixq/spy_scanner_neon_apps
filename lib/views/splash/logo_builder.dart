part of 'splash_view.dart';

class _LogoBuilder extends StatelessWidget {
  const _LogoBuilder();

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageAssets.appIcon, height: 20.h(context));
  }
}
