import "package:flutter/material.dart";

void main() {
  runApp(new MaterialApp(
    home: new Example(),
  ));
}

class Example extends StatefulWidget {
  @override
  ExampleState createState() => new ExampleState();
}

class ExampleState extends State<Example> {

  int currentTab = 0; // Index of currently opened tab.
  PageOne pageOne = new PageOne(); // Page that corresponds with the first tab.
  PageTwo pageTwo = new PageTwo(); // Page that corresponds with the second tab.
  PageThree pageThree = new PageThree(); // Page that corresponds with the third tab.
  List<Widget> pages; // List of all pages that can be opened from our BottomNavigationBar.
  // Index 0 represents the page for the 0th tab, index 1 represents the page for the 1st tab etc...
  Widget currentPage; // Page that is open at the moment.


  @override
  void initState() {
    super.initState();
    pages = [pageOne, pageTwo, pageThree]; // Populate our pages list.
    currentPage = pageOne; // Setting the first page that we'd like to show our user.
    // Notice that pageOne is the 0th item in the pages list. This corresponds with our initial currentTab value.
    // These two should match at the start of our application.
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Here we create our BottomNavigationBar.
    final BottomNavigationBar navBar = new BottomNavigationBar(
      currentIndex: currentTab, // Our currentIndex will be the currentTab value. So we need to update this whenever we tab on a new page!
      onTap: (int numTab) { // numTab will be the index of the tab that is pressed.
        setState(() { // Setting the state so we can show our new page.
          print("Current tab: " + numTab.toString()); // Printing for debugging reasons.
          currentTab = numTab; // Updating our currentTab with the tab that is pressed [See 43].
          currentPage = pages[numTab]; // Updating the page that we'd like to show to the user.
        });
      },
      items: <BottomNavigationBarItem>[ // Visuals, see docs for more information: https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html
        new BottomNavigationBarItem( //numTab 0
            icon: new Icon(Icons.ac_unit),
            title: new Text("Ac unit")
        ),
        new BottomNavigationBarItem( //numTab 1
            icon: new Icon(Icons.access_alarm),
            title: new Text("Access alarm")
        ),
        new BottomNavigationBarItem( //numTab 2
            icon: new Icon(Icons.access_alarms),
            title: new Text("Access alarms")
        )
      ],
    );


    return new Scaffold(
      appBar: AppBar(
        title: Text("ABC"),
      ),

      bottomNavigationBar: navBar, // Assigning our navBar to the Scaffold's bottomNavigationBar property.
      body: new PageBase(currentPage)
    );
  }
}

class PageBase extends StatelessWidget {
  PageBase(Widget this.currentPage);

  final Widget currentPage ;

  Widget _buildText(
      {String text, Color color, Color textColor = Colors.white}) {
    return Container(
      alignment: AlignmentDirectional.center,
      color: color,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 32.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget build(BuildContext context) {
//    return new Center(child: new Text("Page Three"));
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VerticalPadding(
            color: Colors.green[100],
            child: _buildText(
                text: 'HEADER', color: Colors.white, textColor: Colors.black),
           ),
          currentPage
        ]
      )
    );
  }
}



class PageOne extends StatelessWidget { // Creating a simple example page.
  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text("Page one"));
  }
}

class VerticalPadding extends StatelessWidget {
  VerticalPadding({
    @required this.child,
    this.padding = 10.0,
    this.color = Colors.white,
  });

  final double padding;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: EdgeInsets.symmetric(vertical: padding),
      child: child,
    );
  }
}

class PageTwo extends StatelessWidget {
  // Creating a simple example page.
  GlobalKey _globalKey = GlobalKey();
  double _width = double.infinity;
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return
        PhysicalModel(
          elevation: 8.0,
          shadowColor: Colors.lightGreenAccent,
          color: Colors.lightGreen,
//          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            key: _globalKey,
            height: 48.0,
            width: _width,
//            padding: EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom:0.0),
            child: RaisedButton(
              padding: EdgeInsets.all(0.0),
              child: Text(
                  "Click Here",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )
              ),
              onPressed: () {
///                setState(() {
                  print('Button pushed');

                  if (_state == 0) {
//                    animateButton();
                  }
                //}
              },
              elevation: 4.0,
              color: Colors.lightGreen,
            ),
          ),
//        ),
//      ),
    );
  }
}

class PageThree extends StatelessWidget { // Creating a simple example page.

  Widget _buildText(
      {String text, Color color, Color textColor = Colors.white}) {
    return Container(
      alignment: AlignmentDirectional.center,
      color: color,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 32.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded (child:
      // Scaffold(
        Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          VerticalPadding(
          color: Colors.green[100],
          child: _buildText(text: 'First', color: Colors.green),
          ),
          VerticalPadding(
          color: Colors.red[100],
          child: _buildText(text: 'Second', color: Colors.red),
          ),
          SizedBox(
          height: 50.0,
          child: _buildText(
          text: '50 pt', color: Colors.white, textColor: Colors.black),
          ),
          VerticalPadding(
          color: Colors.blue[100],
          child: _buildText(text: 'Third', color: Colors.blue),
          ),
          Expanded(
          flex: 1,
          child: _buildText(
          text: 'flex: 1', color: Colors.white, textColor: Colors.black),
          ),
          VerticalPadding(
          color: Colors.brown[100],
          child: _buildText(text: 'Fifth', color: Colors.brown),
          ),
        ])
      );
  }
}