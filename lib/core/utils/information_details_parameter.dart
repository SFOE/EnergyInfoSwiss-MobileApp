

/// This class provides all properties for a information details page
///
/// It is passed as the extra argument in go_router when navigating
/// to a information details page (like Rechtliches, Barrierefreiheit, ...)
class InformationDetailsParameter{
  final String title;
  final String url;
  const InformationDetailsParameter({required this.title, required this.url});
}