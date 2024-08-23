The real-time multiplayer Blokus game, developed by Charles Tucker and Pablo L. Guerra, was designed using Flutter and Supabase as part of the final project for GMU’s ISA 681 ([Secure Software Design and Programming](https://dwheeler.com/secure-class/)) class. The game provides an engaging multiplayer experience, leveraging Supabase as the backend and Flame as the game engine.

The project requirements were as follows:

> You are part of a small development shop that has been asked to develop a network-enabled game system. The games will be played between competitors that do not trust each other and may try to cheat.

> Your software must actively prevent players from cheating, that is, from exploiting the program to win or to force other players to lose. Act as if players who win will earn money, while players who lose will lose money; thus, the system must know which players win or lose, and must enforce the game rules even if the players are actively trying to circumvent the rules. Note that a system where all competing users log in as a single account cannot possibly meet this requirement. The software must support at least 50 simultaneous players (in most cases this implies there will be a large number of simultaneous games).

> The program must be designed to be secure. You must avoid vulnerabilities like SQL injection, buffer overflows, accepting invalid input, and passing sensitive data unprotected. You will also need to authenticate all users. You do not need to prevent out-of-game collusion.

## Materials and Methods

The game was developed using the Flutter framework, written in the Dart programming language. The Supabase platform was used to provide real-time functionality for multiplayer gameplay, while the Flame game engine was used to implement the game mechanics and rendering.

User authentication was handled using the Supabase Magic Link feature, which allows users to sign in by clicking a link sent to their email address. The link is valid for a limited time and contains a one-time password, ensuring secure authentication.

Real-time communication between players was facilitated by Supabase’s 'Realtime' feature, which allows clients to subscribe to changes in the database and receive updates in real-time. This feature was used to synchronize game state between players, ensuring all players in a game room see the same board and pieces, without impacting performance.

Turn validation is handled based on the game rules, ensuring only the player with the given ID and color can place a piece on the board. The game logic enforces the rules of Blokus, such as piece placement, rotation, and adjacency restrictions.

A session timeout feature was implemented to handle cases where a player disconnects or leaves the game. If a player does not make a move within ten minutes, they are automatically forfeited, and the game continues without them.

Upon finishing the game, a score screen is displayed showing the final scores and the order in which pieces were placed.

## Results

The development of the real-time multiplayer Blokus game met several key project requirements, but also revealed some limitations. The primary outcomes include:

1. Real-time Multiplayer Gameplay: Supabase’s ‘Realtime’ feature successfully synchronized the game state across multiple players, ensuring that all participants in a game room experienced the same board updates simultaneously. This demonstrated the effectiveness of using Supabase for real-time communication in a multiplayer gaming environment.
2. User Authentication and Security: The implementation of Supabase’s Magic Link authentication provided a secure login method, preventing unauthorized access. This met the project’s security requirements by ensuring that only authenticated users could participate in the game.
3. Turn Validation and Rule Enforcement: The game logic enforced Blokus rules, restricting piece placement and ensuring only the correct player could take their turn. This reduced the likelihood of cheating and maintained the integrity of the game.
4. Session Timeout Feature: The inclusion of a session timeout mechanism automatically forfeited inactive players, ensuring that the game could continue without disruption. This feature maintained the flow of gameplay even if a player disconnected or became inactive.
5. Unresolved Issues: Despite these successes, the game had some unresolved issues. The score calculation logic was inconsistent, sometimes failing to correctly tally the final scores. Additionally, the endgame logic was incomplete, occasionally leading to games that could not properly conclude. The game also initially implemented a peer-to-peer architecture for turn validation, which did not align with the professor’s preference for a server-client model.

## Discussion

This project effectively demonstrated the capabilities of Flutter, Supabase, and Flame in building a secure, real-time multiplayer game. While core functionalities were successfully implemented, the issues with score calculation and endgame logic highlight the need for further refinement. The initial peer-to-peer approach for turn validation, although functional, did not meet the optimal security standards offered by a server-client model. Addressing these issues in future iterations will be crucial for enhancing the game’s reliability and scalability.

## Conclusion

The real-time multiplayer Blokus game prototype showcased the potential of modern web technologies in developing secure multiplayer experiences. Despite challenges like inconsistent scoring and incomplete game logic, the project provides a strong foundation for future development. Transitioning to a server-client architecture and resolving existing issues will be key to building a more robust and scalable multiplayer game.
