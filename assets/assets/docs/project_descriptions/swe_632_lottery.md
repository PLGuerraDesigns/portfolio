The SWE 632 Lottery Web App was developed as part of the [User Interface Design and Development course](https://cs.gmu.edu/~tlatoza/teaching/swe632f21/home.html) at George Mason University (GMU). This project, created in collaboration with Afrina Sharmin and Suzzana Rafi, offers an immersive gaming experience that includes Wheel of Fortune and Scratch Cards, allowing users to earn virtual currency to unlock GMU-branded merchandise. The application was built using Flutter and Dart, leveraging the capabilities of Progressive Web Apps (PWAs) to provide a seamless user experience across various devices. The app is fully functional and hosted on GitHub Page.

## Materials and Methods

The app was written in Dart using the Flutter framework, and followed an iterative development process based on the lectures and assignments from the course. Each submission was published on GitHub Pages to allow for easy access and testing by peers and the instructor.

#### Submission 1 [(v0.0.2)](https://plguerradesigns.github.io/swe_632_lottery/v0.0.2/) included the following features:

1. A light and dark theme based on the GMU color palette and brand assets
2. A frosted glass effect surrounding the main content area on each screen
3. A home screen with the ability to change themes, navigate to the games, and view the list of rewards
4. A Wheel of Fortune game allowing users to press a button to spin the wheel and potentially win a reward
5. A Scratch Cards game allowing users to scratch off a grid, revealing a reward or empty space, and winning if they uncover three of the same reward
6. A rewards screen displaying the list of available rewards and whether they have been unlocked
7. Pop-up dialogs to display the results of the games and game instructions

This submission was critiqued by peers, who provided a heuristic evaluation of the app's usability and design. The following feedback was selected to be addressed in the subsequent submission.

> **Match between the system and the real world:** Users may become confused when they hover over interactive elements, such as icons, without any tooltip or other explanation of what it does. This delay in response might make navigating less natural and less enjoyable for users as a whole.

> **Help and Documentation**: Users are left without instructions or resources to browse and comprehend the functionalities of the website due to the lack of support and documentation on the homepage. The "Help and documentation" heuristic is broken by this omission, which could lead to confusion and lessen user satisfaction

> **User Control and Freedom**: There is no cancel or back option when a game ends. We can only select to play again or view rewards.

> **Error Prevention**: There is an unusual output while playing the scratch card game. The player is getting rewards without scratching all the blocks in the scratch cards.

> **Consistency and Standards**: The probability of winning in scratch cards is very low, approximately 0.

> **Match between system and the real world**: The heuristic is broken by the wheel of fortune’s use of “?” symbols, which leaves users in the dark about possible prizes. Because players in classic Wheel of Fortune games are aware of the potential results, there is transparency and a clear understanding of what to expect.

#### Submission 2 [(v0.0.4)](https://plguerradesigns.github.io/swe_632_lottery/v0.0.4/) introduced the following changes based on the feedback:

- Icon buttons were replaced with text buttons to improve clarity and user understanding.
- A Help button was added to the home screen, which opens a dialog with instructions on how to play the games.
- A 'Go Back' button was added to the results dialog, allowing users to return to the game screen after viewing their results.
- The Scratch Cards game was updated to prevent rewards from being revealed until all blocks are scratched off.
- The probability of winning in the Scratch Cards game was increased to 50% to improve user satisfaction.
- The Wheel of Fortune game was updated to display the potential rewards instead of question marks, providing transparency to users.
- The Wheel of Fortune's color scheme was updated to match the GMU brand colors, enhancing visual consistency.
- Supporting content was moved into the Frosted containers to improve the visual hierarchy and user experience.
- The initial theme was set to the user's system preference.

This submission was then evaluated through a 'Think Aloud' usability test, where participants were asked to complete specific tasks while verbalizing their thoughts. The test details and results are as follows:

> **Task Description** In this user study, participants will engage with the SWE 632 Lottery web app, which offers two primary use cases: Spin the Wheel and Scratch Cards. Participants will be tasked with simulating the user experience by unlocking ten different GMU merchandise rewards. To achieve this, they must successfully unlock five rewards by interacting with the Spin the Wheel feature and five more through Scratch Cards. The study will assess the user-friendliness, engagement, and overall effectiveness of these features in providing an enjoyable and rewarding experience for the participants while gauging the app's appeal and functionality in promoting GMU merchandise.

> > **Participant A**
>
> > **Critical Incidents:**
>
> 1. User was unable scroll through the reward list using gestures or arrow keys. The user was able to overcome this by dragging the scrollbar.
> 2. The user had issues figuring out how to scratch the card. The UI took some time to register and render the users' inputs while scratching the card.
> 3. The application froze for about 5-8 seconds after the user attempted to exit the rewards screen.
> 4. The user had to constantly move between the game page and rewards page to identify the number of rewards won.
> 5. The user had to manually count the number of unlocked rewards to determine if the task was completed.
>
> > **Post-Task Interview Notes:**
>
> 1. The user expected the wheel of fortune game to have empty spaces where they would not win any prizes.
> 2. The user initially assumed that the scratch card game required three items in a row instead of three items anywhere on the card.

> > **Participant B**
>
> > **Critical Incidents:**
>
> 1. The user played spin the wheel game first. The wheel initially showed the user that he won a cap, but in the popup, it displayed a mug image. After a while, it changed back to showing a cap automatically.
> 2. The user went to the reward view section from the popup, and it showed two rewards: a mug and a cap, even though the user only played the game once.
> 3. The user had difficulty navigating back to another game from the reward and game pages. He had to switch reward and game page frequently.
> 4. The user got confused about how to play the scratch card game but eventually found instructions on how to play.
> 5. After finishing the first round of the scratch card game, the user went to the reward page. When he returned to the scratch card game, he expected to see a new game page, but he found the old page instead. To access a new game page, the user needed to go back to the home page repeatedly.
> 6. The user attempted to fix the issue by refreshing the browser, but it loaded the home page, where the user expected to find the scratch card for a new game.
> 7. The user discovered that all the rewards were gone after refreshing the browser.
>
> > **Post-Task Interview Notes:**
>
> 1. The user thought there was an issue with the spin the wheel game when he won a cap.
> 2. The user expects to see a cross sign in the top right corner to navigate back from the reward page.
> 3. The scratch card game doesn't automatically load a new game page in both cases, whether the user wins or loses the game.
> 4. While playing the spin the wheel game, the user mentioned that the wheel spins very quickly, which caused discomfort to his eyes.

> > **Participant C**
>
> > **Critical incidents:**
>
> 1. For spin the wheel game, the user clicked on the “spin” button multiple times while the wheel was still spinning from the first click, and had multiple rewards pop up one after another after it was done spinning.
> 2. For the scratch card game, when the user won a reward, he selected to view the reward and selected “go back”, the page did not reset to the original state, he had to click the back button and start the game again to get a new game page.
> 3. The user was confused after scratching three cells as he was expecting the game to end there.
> 4. The user did not know how much he had to scratch for it to be accepted. He first scratched each cell a little and when he was done with all cells nothing popped up. He had to eventually scratch more for it to pop up the notification.
>
> > **Post-Task interview notes:**
>
> 1. For spin the wheel game, the user won 5 unique rewards after 5 tries, there were no repetition of rewards. Getting the same reward twice would have made it more realistic.
> 2. The user won a prize every time in the spin the wheel game, there were no options like “bad luck, try again” or something similar. That was also not expected by the user.
> 3. The user had to scratch all the cells to get three matching rewards, which was tiring to do. He would have preferred scratching three times and having the game ending there.
> 4. After scratching 8 out of the 9 cells, he did not see any point in having to waste time scratching the last cell as none of the other cells had any two matching rewards, he thought the game could have ended by then.

> > **Participant D**
>
> > **Critical incidents:**
>
> 1. The user initially thought they could only scratch a max of three sections on the scratch card game and was confused when nothing happened. The user then realized that they had to scratch the entire card to end the game.
> 2. The user was unable to reset the scratched scratch card after clicking outside the end game dialog box. The user was able to fix this by navigating to the home screen and back to the scratch card game.
> 3. The user was able to click the spin the wheel button multiple times and successfully won several items in rapid succession, instead of one at a time.
>
> > **Post-Task interview notes:**
>
> 1. The user had no additional comments after completing the task.

> > **Usability Issues**
>
> 1. **B5, C2:** The scratch card game does not automatically load a new game page after going to the reward page and coming back to the game page. When the user wishes to play the game again, the page remains in its previous state, and this presents a significant usability problem that needs to be addressed.
> 2. **A2, C3:** The user was not sure how much to scratch the card to make actions happen, and the UI responded slowly to their scratching. They expected the game would end after scratching three cells, but it didn't provide them with any feedback, leaving them confused as to what was going on. The user became frustrated due to the absence of timely response and clear instructions.
> 3. **A1, B3:** Another usability issue is the need for the user to frequently switch between the game page and the rewards page in order to keep track of the number of rewards they have won. This constant back-and-forth navigation made it challenging for the user to easily return to their game from either the reward or game pages, causing a disruption in the overall gaming experience.
> 4. **C3, D1:** The user thought they had to scratch a maximum of three cells, but the game required them to scratch all nine cells which was time consuming and unnecessary according to the users. This is a usability issue that has to be fixed.
> 5. **C1, D3:** The user can get multiple rewards at a time by clicking the spin button multiple times while one spin is still going on. It should be one reward after one spin instead. This is again a usability issue that needs to be fixed.

#### Submission 3 [(v0.1.4)](https://plguerradesigns.github.io/swe_632_lottery/v0.1.4/) addressed the following usability issues identified in the Think Aloud test:

1. **B5, C2:** A 'Reset' button was introduced to the Scratch Cards game, allowing users to start a new game after viewing their rewards.
2. **A1, B3:** A rewards tracker was added at the bottom of the game screen, displaying the rewards.
3. **C1, D3:** The spin functionality was disabled while the wheel was spinning to prevent multiple rewards from being displayed simultaneously.

This submission was then evaluated through a 'Design Critique' session, where we
identified several weaknesses based on design principles learnt thus far in the course and implemented them in the penultimate submission.

#### Submission 4 [(v0.3.1)](https://plguerradesigns.github.io/swe_632_lottery/v0.3.1/) included the following changes:

1. Introduce the use of coins to allow users to unlock selected prizes with coins (L7: Keep users in control)
2. Indicate which UI elements can be interacted with (L8: Hinting)
3. Support for different screen sizes including mobile and ultra-wide (L8: Responsive Design)
4. Revise text content to make user actions clear (L8: Clarity of Wording)
5. Add click-to-scratch behavior to enable easier scratch-card gameplay (L8: Supporting Users with Disabilities)
6. Enable always visible scrollbar to allow for drag to scroll (L8: Universal Design)
7. Prevent user from shuffling the wheel prizes while spinning (L9: Preventing Error)

A second round of 'Design Critique' was conducted to determine any major remaining issues with the app, and the final submission was prepared based on the weaknesses identified.

#### Submission 5 [(v0.6.1)](https://plguerradesigns.github.io/swe_632_lottery) included the following changes:

1. The default Flutter icon was replaced with a custom logo for a more unified look and feel.
2. The alignment and size of text elements were adjusted for better readability and consistency.
3. The order of the prizes in the rewards bar was sorted based on the unlock order, showing the most recent prize first.
4. Filter and Sort options were added to the rewards screen to allow users to view prizes based on different criteria.
5. A shimmer effect was added to highlight and draw attention to important interactive game elements.
6. A scale-on-hover effect was added to certain UI elements to provide visual feedback to users.
7. The endgame dialog was replaced with a prize scale animation accompanied by confetti.
8. A new 'Game Analysis' screen was added to display the user's game statistics including, 'Coins Analysis', 'Game Analysis', and 'Reward Analysis'. The user can view the data in a tabular format or chart format.

## Results

The final version of the SWE 632 Lottery Web App significantly improved usability and user engagement. Key outcomes include:

1. **Enhanced Usability:** The addition of a ‘Reset’ button and rewards tracker streamlined navigation, while disabling the spin button during spinning prevented interaction issues.
2. **Improved Interaction:** Introducing coins for prize unlocking and making UI elements more responsive and clear enhanced the gaming experience across various devices.
3. **Visual Refinements:** A custom logo, better text alignment, and visual effects like shimmer, hover scaling, and endgame animations (including confetti) improved the app’s appeal.
4. **Comprehensive Analytics:** The new ‘Game Analysis’ screen provided detailed gameplay statistics, adding depth to the user experience.

## Discussion

The iterative development process was crucial in resolving usability concerns and enhancing user interaction. Feedback-driven updates, such as clearer instructions and visual improvements, led to a more refined app. However, a few issues remain, including clipped visuals on smaller devices, which remain to be addressed.

## Conclusion

The SWE 632 Lottery Web App evolved into an engaging, user-centric application through continuous user feedback. Hosted on GitHub Pages, it showcases both technical expertise and a strong understanding of user-centered design principles, though there are still areas for further improvement.
