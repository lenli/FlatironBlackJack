---
  tags: tutorial, beginner, OOP, Object-Oriented Programming, model 
  languages: objc
---

BlackJack With Views 
=======

### Goals 
- Work With Views via the storyboard to create a playable BlackJack Game 
- Create a full MVC 

### Instructions 

BlackJack isn't very fun with NSLogging.  Let's add a view so someone can actually play our blackjack game on an iPhone. We'll think about what elements are necessary on our view to play a game of blackjack.  

## Storyboard

First we need to add a storyboard to our project.  The storyboard gives us a place to configure the user interface of our app.  Add a storyboard to your project and make sure it's setup as the default storyboard for your project.  

  1. Select File -> New File -> User Interface -> Storyboard
  2. Select iPhone for Device Family 
  3. And Save your storyboard with the default name into your projects directory 
  4. From the Project Navigator's main interface select your storyboard.  
  5. Let's add our first view to the storyboard.  From the Utilities navigator, in the Object Library, select `View Controller` and drag the View Controller to the Storyboard. 
  6. Your View Controller will automatically be configured as the initial view controller for your project. 
  7. You probably have some code similar to the following in your AppDelegate's didFinishLaunchingWithOptions: method. 

  ```objc
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
  ```

  8.  You can delete all of that code.  The storyboard magically handles configuring the window and adding the initial View Controller.  

  ## User Interface 

  Next let's add the UI elements to our ViewController that we'll need to play a game of Blackjack.  

  1. We're going to have two buttons in our interface.  One will deal the initial hand and the other will hit.  
  2. Drag two UIButtons from the object library and place them to your liking.  Modify the labels to say (you guessed it.. ) hit and deal. 
  3. Next we'll need to present each card.  We'll be using UILabels to present our cards. Drag a UILabel from the object library to your storyboard.  Resize the label to look something like a card. 
  4. In the attributes inspector, change the Background color of your label to a color of your liking. 
  5. In the attributes inspector's drawing section, set the label to hidden.   
  6. Duplicate the label until we have a total of 5 labels.  (We'll ignore the fact that you could technically draw more than 5 cards as that's extremely unlikely and unnecessarily more complex).  
  7. Next create a label for score 
  8.  Create one last label that tells the user if they got a blackjack or if they busted

  ## UIViewController Subclass 

  We've created our UI, but right now we don't have a way to interact with it in code.  We connect our storyboards to code by creating a subclass of UIViewController and assigning that subclass to our storyboard View Controller

  1. Create a new file - > Objective-C Class  
  2. Give your class the name "BlackjackGameViewController" with Subclass of UIViewController 
  3. Back in the storyboard, select your view controller and open the identity inspector.  Set the custom class to BlackjackGameViewController.  We've now created a connection between our UI and our code.  Let's connect our Interface elements to our code with Outlets and actions.  
  4. With your ViewController selected in the storyboard, open the assistant editor.  This gives you a split view between your storyboard and your custom view controller. 
  5. Select your first 'cardLabel' and ctrl + drag to the interface in your .h file.  For Each card we'll select the following options: Connection: outlet, Name (card1, card2, card3, etc...) Type: UILabel, and storage: weak.  
  6.  Repeat these steps for each of your cards to create a total of 5 outlets for each label. 
  7. Create outlets for your score and blackjack/bust labels using the same steps.  
  8.  For hit and deal, we want to make actions instead of outlets.  Actions allow us to link an action, such as the pressing of a button, to a method in code.  Control drag from the hit and deal buttons to the interface to declare your action methods.  Make sure to change the Connection type to action (not outlet). 
  9.  You'll have a corresponding method automatically created for you in your .m.  Go ahead and test that your buttons work by adding an NSLog to each of those methods.  In the deal method have your log output deal and in the hit button have your log output hit. 

  ## Implementing your Blackjack Game 

  1. add a property of type BlackjackGame to your BlackjackGameViewController's .h file. In the viewDidLoad method,  alloc]init] your BlackjackGame property.
  2. Next, also in your viewDidLoad method, call your BlackjackGame's deal method and update your first two card labels.  UILabel has a text property.  You should update the text of your label to match the description of each of your playing cards.  
  3. Implement your deal and hit methods to perform the appropriate functions. ie. in deal, instantiate a new game, remove all label text and add two new labels for a new deal, and in hit, call the game's hit method and update a third (or 4th or 5th) card with the description of the card that was hit.  
  4. After each move you should upgrade your score label, and if you bust or get a blackjack you should appropriate your bust/blackjack label.  

  You might want to create an 'updateUI' method that you call after each action to update the UIElements that are changing.  You don't necessarily have to do this, but it will probably present itself in refactoring.      





