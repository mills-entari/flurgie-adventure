# flurgie-adventure
Game Learning project in the Machine Learning Laboratory at the University of Hawaii at Manoa.

PDF link to report on project: [Statistical Learning in Video Games](https://goo.gl/kzFBbE)


# Statistical Learning in Video Games


## Abstract
Serial reaction time tasks experiments have been used to study how people learn statistical structures,
such as conditional probability and joint probability, to improve their performance with these tasks. The
experiments have demonstrated their effectiveness at measuring a person’s learning rate of the
structures, but they also tend to be under artificial conditions and with limited participants. Video games
give us an opportunity to expand upon this in multiple ways. They constitute a more natural
environment for creating tasks where people learn to achieve their goals. In addition, the hardware used
to play modern games today has the ability to connect online, which creates the opportunity to target
more participants. This write-up will discuss our work in the development of a mobile game on iOS that
is designed to implement statistical structures that are tailored into the gameplay as a serial reaction
time task in order to study how players learn them.


## 1. Introduction
Every day we are faced with choices that often involve predictions. We make predictions by extracting statistics from what we observe (Hunt & Aslin, 2001). Thus, a valid question is how do people derive these statistics from the world they experience? Psychophysicists have explored this question and have used serial reaction time tasks (SRTT) to measure a person’s physical reaction time to sensory cues (visual, auditory, etc.). A visual SRTT may involve cue lights that activate in a specific order. Participants would press a button representing the next light in the sequence to be activated based on what was previously observed. An auditory SRTT may incorporate a similar approach except with audible tones and participants signal what the next tone in a sequence would be.

Can we implement SRTTs in software and can we then analyze the data to the same effectiveness as traditionally done by psychophysicists? A naïve approach could be to emulate exact copies of existing physical experiments, but software allows us to push the limits of this and explore new opportunities of creativity in this area. Video games are one way this can be explored by integrating experiments that are similar to the classical SRTT ones, with a fun twist. This can also create a more natural setting to study the participant learning a probability distribution since games are commonly played today in our society.


## 2. Background
Our work is inspired by the research done by Hunt & Aslin (2001) studying statistical learning in a serial reaction time task. In their experiments, a box with illuminable buttons up was constructed. Figure 1 illustrates one of their designs for a box from their paper.

| ![Figure 1. Light box device illustration from Hunt & Aslin (2001). This figure illustrates the light box with eight buttons used in their 3rd experiment and a sequence of how the buttons could light up.](https://www.imberstudios.com/images/slvg/light_box_2.png) |
|:--:|
| Figure 1. Light box device illustration from Hunt & Aslin (2001). This figure illustrates the light box with eight buttons used in their 3rd experiment and a sequence of how the buttons could light up. |

The purpose of this device was to construct a language of words, where each word consisted of elements that were a sequence of buttons that lit up. For example, the letter “A” may consist of the buttons 1 and 7 lighting up in sequence. A word itself may contain several elements, though typically two to three were used in the experiments. Words were arranged with certain probabilities in the language to see if people could learn them. This setup allowed Hunt & Aslin to find which distributions people would use to enhance their performance. In one of their experiments, for words with two elements, they showed that the mean reaction times for the first element were higher than the second element, and that the difference increased with more training. The implication of this is that people were learning the patterns of the elements for words and were able to predict the second element based on their observation of the first one. Another observation noted by Hunt & Aslin was that the reaction time for the first element decreased and eventually reached an average value, which the authors accounted as a change due to motor learning. This is an interesting observation because the first element cannot be predicted and demonstrates how participants got physically better at the task until they reached a level of physical performance they could not surpass.


## 3. Project Goals
The primary goal of this project is to apply the concepts of statistical learning in SRTTs, as demonstrated by Hunt & Aslin, into software as a video game. We would like to see if players can implicitly learn a probability distribution embedded within the game. Data to confirm or deny this will be obtained from the reaction time it takes for a player to correctly react to a stimulus in the game. Games serve as an ideal choice for SRTT experiments because in games people are self-motivated to improve their performance and work toward a goal.

The author of this project has an interest in game development and would like to find ways to apply statistical learning into games as a way to improve a player’s gameplay experience. Thus, a potential outcome from this project could be a software code base usable by other developers for integration into video games to allow for the game to adapt to a player based on a their performance.

Questions that this project seeks to answer:

1. Is it possible to create a video game using the SRTT paradigm and what are the implications of this for further study in statistical learning?
2. Can we capture large amounts of performance data from numerous players and store this for future analysis?
3. Could measuring reaction times help improve the ways games adapt to players?

In the following subsections we now discuss how we hope to expand upon the work done by Hunt & Aslin.

### 3.1 Target More Participants
Software gives us the ability to target more participants, particularly with the advent of popular distribution stores such as Apple’s App Store. With a distribution store, a SRTT based experiment could be released for free and be available for download to anybody who has a compatible device. Modifications and enhancements can also easily be pushed out through this same mechanism to expand an experiment.

### 3.2 Data Collection & Storage
Integrating reaction time experiments into software allows us to easily collect data at designed intervals and store it in a remote database. As long as a person has an Internet connection they can upload their data. Even in cases where there is no Internet connection, the player should still able use the software and it should attempt to cache collected data locally for upload at a later time.

### 3.3 Engaging Experience
It may not always be enough to simply ask participants to conduct experiments through software. A research experiment can be made to feel less artificial and more immersive when designed as a game. A game can give players meaningful goals that they are motivated to achieve. This serves two important points: first, there is more opportunity for participants to contribute data because players will want to play the game more. Secondly, because it is important for participants to not directly focus on what they may be learning in SRTTs. The challenge with making a game however is whether it is fun and that is not something that can be easily measured as making a game fun is more of a black art than a recipe to follow.


## 4. Hardware Requirements
With our goals outlined, we will detail the hardware requirements needed for the game.

### 4.1 Mobile Access & Web Enabled
The game should be developed for a mobile device, providing for ease of access. We want players to be able to play and stop at any time, so the tests conducted in the game should be kept short, perhaps to less than 30 seconds. As mentioned in our goals to target more participants and store collected data remotely, a device capable of accessing the Internet will be necessary. Ultimately, the purpose of this requirement is to allow data to flow in from a person at any time they can play the game.

### 4.2 Accelerometer
Players should not feel encumbered by the controls of the game, nor spend a significant amount of time trying to learn them. The rules of the game should be self-explanatory without the requirement of a tutorial, as is common in traditional games. While there may be a need for a user interface, it should be minimal to avoid any cognitive load on players. Utilizing the accelerometer of a device allows for natural gestures based on hand movements and removes the need for certain buttons. Players can also benefit from this with faster reactions than what may be possible with traditional interfaces.

### 4.3 Selected Target Device
With the specified hardware requirements, two platforms standout as candidates to develop our research game, Apple’s iOS and Google’s Android operating systems. We chose to develop on iOS due to its wide availability, standardized hardware, streamlined development process and its familiarity with the author. This operating system will allow us to support iPhone, iPod Touch and iPad devices.


## 5. Design Considerations
We must be careful to create a design that has the right balance of gathering useful research data and having a game that is fun. It is difficult to prescribe an exact recipe for a fun game, so we will first focus our design considerations on what we need to gather data for SRTT experiments. Our intention is to then evolve a fun game out of this.

### 5.1 Motor Learning
Based on the prior work done by Hunt & Aslin (2001) we know that we need to find a way to measure the reaction time it takes for a player to react correctly to a stimulus. This is the time needed to learn the statistical structure, which is the time from a stimulus to a location dependent on it. In order to capture the reaction time as accurately as possible we must remove motor learning as described in section 2.

For example, when using our target device with an accelerometer, the player may not necessarily know how the movement will work for their character until they try tilting their device in a few directions. The time it takes to get used to the accelerometer should not be factored into their reaction time. In general, this motor learning time should decrease with experience in the game.

It is important to keep the motor learning process similar to what must be done during the reaction time period. In the previously mentioned accelerometer example, if the sensitivity of the accelerometer were drastically changed after activating the stimulus, it would affect how the player reacts to the game world and not accurately reflect their response time to the stimulus. Ideally, by the time the player activates the stimulus they will have adjusted and be ready to react. If the player for some reason fails to complete the motor learning phase, then the test is invalid and can be restarted.

### 5.2 Learning Probability Distributions
The primary matter at hand when conducting these experiments is whether players can learn the underlying probability distribution in games. A major question that must be answered in any design is how to embed distributions into the gameplay. It should be possible for players to detect probabilistic patterns based on what they observe with the stimulus in order to predict how to respond correctly to it.

In summary, we want players think about P(S2|S1), that is, the probability of S2 given S1, where:

* S1 = Stimulus
* S2 = Correct response to the stimulus (S1)

Mapping this as a probability distribution within a game is one of the major design challenges.


## 6. Game Design
Several designs were considered for this project, but we ended up selecting one that was as simplistic as possible. In this design, players take control of a character that falls through the sky. As the character falls, the player must grab a pillow positioned within a specified region and then use that pillow to land in a basket that is located on the ground. The pillow is the stimulus and the time taken to grab the pillow serves as the motor learning period; whereas, the time taken thereafter to land in the basket is the reaction time that we are interested in measuring.

There is precedence for this type of game. In late 2012 a game titled “Sky Hero” was released on iOS with a similar game style to ours in which a character falls in the sky collecting objects and avoiding enemies. It should be noted however that game did not have any influence on this game as it was released well after we had completed the development of the game for this project. We mention it merely to show there are games of this type that people currently play.

Control of the character in our game is handled with the accelerometer of the device. When the player tilts their device left or right it steers the character left or right on the screen. A steeper tilt results in faster steering. Similarly, if the player tilts their device up or down it will adjust the speed at which they fall between a predefined minimum and maximum.

The game world is partitioned into two screens. The first screen contains the pillow and the second has the basket. Each screen is divided into eight columns, which are invisible to the player, and the pillow or basket will be positioned within one of these columns near the bottom of the screen. When the player starts the test, they will be positioned at the top of the first screen and start to accelerate downward, as if gravity were pulling them. Once they fall beyond the bottom of the first screen, the second screen is then displayed and the player starts to fall from the top of the second screen. The second screen contains the ground and the test will conclude upon reaching the bottom of this second screen.

### 6.1 Positioning of the Pillow & Basket
The method in which the pillow and basket are positioned is determined based on the game mode used. Two game modes are currently available, which we have dubbed Random and A1. In the Random mode, the position of the basket is completely random and has no correlation to the position of the pillow. In A1, a Normal distribution is used to position the basket based on where the pillow was located. To keep the implementation as simple as possible, the distribution is mapped directly onto the game world. Figure 2 demonstrates a scenario of how the pillow and basket could be placed in the game.

| ![Figure 2. Pillow and basket screens in A1 game mode. This figure shows an example of the A1 game mode and where the basket was placed in relation to the pillow. Note that the Normal distribution curve is not actually displayed in the game and is shown here for illustration purposes. This particular curve is always centered with the highest probability at the center of the pillow. The x-axis represents the horizontal location of where the basket will appear and the y-axis represents the probability of the basket appearing at that horizontal location based on where the pillow was.](https://www.imberstudios.com/images/slvg/normal_overlay_1.png) ![Figure 2. Pillow and basket screens in A1 game mode. This figure shows an example of the A1 game mode and where the basket was placed in relation to the pillow. Note that the Normal distribution curve is not actually displayed in the game and is shown here for illustration purposes. This particular curve is always centered with the highest probability at the center of the pillow. The x-axis represents the horizontal location of where the basket will appear and the y-axis represents the probability of the basket appearing at that horizontal location based on where the pillow was.](https://www.imberstudios.com/images/slvg/normal_overlay_2.png) |
|:--:|
| Figure 2. Pillow and basket screens in A1 game mode. This figure shows an example of the A1 game mode and where the basket was placed in relation to the pillow. Note that the Normal distribution curve is not actually displayed in the game and is shown here for illustration purposes. This particular curve is always centered with the highest probability at the center of the pillow. The x-axis represents the horizontal location of where the basket will appear and the y-axis represents the probability of the basket appearing at that horizontal location based on where the pillow was. |

In the first screen (left image), the pillow is randomly placed. The mean of the distribution is placed at the center of the pillow and a standard deviation of 1 is used to compute a location to place the basket based on these parameters. On the second screen (right image), the basket is located close to the mean of the pillow from the first screen and is expected to occur with this distribution.

We use a circular boundary with respect to the distribution mapping and the movement space of the character. This means that the basket may appear on the opposite side of the screen (horizontally) if it is possible within the distribution. Similarly, a character can be moved to the other side of the screen by crossing over from the opposite side.

The character movement speed is controlled by two different values. For vertical movement, it is controlled by a gravity value that the physics engine uses to “pull” the character downwards. There is a speed limit we have artificially set for the character so that its vertical movement speed will remain constant after a certain value. This was done to make the development simpler instead of creating drag forces that would cause the character to reach terminal velocity. For horizontal movement, the acceleration is handled by the accelerometer, and similar to the way we handled gravity, there is a speed limit we have set for this movement which is independent of the speed limit for vertical movement.

### 6.2 Tuning and Difficulty of Game
Tuning of the game is still an ongoing effort in the project. This includes configurable sensitivity of the accelerometer and also the allowed minimum and maximum speeds that the character can move through the world. An area of concern with allowing adjustable sensitivity or character movement speed is how it will affect reaction time results. A normalization process would have to be used to ensure consistent data analysis. Without that, a character that moves faster will have a faster reaction time when compared to one that is slower. One way to normalize the data could be to quantify the reaction time as a score which can be weighted based on the sensitivity of the accelerometer or character movement speed.

Tuning the character movement can affect the difficulty of our game. If the character moves fast it will require greater skill to make an accurate prediction and maneuver the character correctly in the world. While this could allow for the ability to make the game more interesting, it is not something we will pursue at this time. In terms of game difficulty, we would like it to be only affected by the statistical distribution used. In section 6.1 we described how the Normal distribution was mapped onto our game world to adjust the positioning of the basket. We are not limited to just this distribution of course. Any statistical distribution that can be mapped onto the same space could also be used. For example, we originally had our A1 distribution implemented as a mirrored Normal distribution. This is a Normal distribution that is reflected. Using the example in the previous section, the graph of the reflected curve for this mirrored version would look like Figure 3.

| ![Figure 3. Mirrored A1 game mode screen. This figure shows the Normal distribution curve for a mirrored version of the pillow screen show in Figure 3. Note that the basket was not actually moved as mirrored mode is disabled in the game.](https://www.imberstudios.com/images/slvg/normal_overlay_2_mirror.png) |
|:--:|
| Figure 3. Mirrored A1 game mode screen. This figure shows the Normal distribution curve for a mirrored version of the pillow screen show in Figure 3. Note that the basket was not actually moved as mirrored mode is disabled in the game. |

We opted to remove the mirroring because we felt it was increasing the difficulty of learning the distribution beyond what we intended for our initial implementation.

### 6.3 Game Engine Highlights
The game engine is the code that drives the main game loop and brings together all the major components such as graphics, audio, physics, artificial intelligence and more. Games use either their own custom engine or a 3rd party one. The best approach depends on a variety of factors related to the project. For this project we chose to write our own custom lightweight engine. Most of the engine was written using the iOS API, except for the physics package where we used a 3rd party open source library: Chipmunk Physics (Lembcke, 2013). These choices allowed us to make development of the engine faster, but at the cost of making it less portable. Our current goals for this project do not require portability, so it was an acceptable compromise.

### 6.3.1 Sending the Data
Each time the player completes a level the data collected for the level is packaged into a JSON string and immediately sent to a remote web server for storage.

Summary of data sent:

* User Name: Used to track the player so that we can tie the results to a specific individual during analysis.
* Result Times (T1 & T2): The time it took to reach the pillow and the basket in the level after the level started. The reaction time from the pillow to the basket is computed by T2 – T1.
* Level ID: Globally unique identifier used to identify this level uniquely in the database.
* Is Completed: If the level was fully completed (player reached both T1 and T2).
* Level Created Date: The date/time that the level was created in GMT format.
* Level Type: If this level was created as Random or A1 mode.

We originally treated the data as extremely valuable and created a design to ensure the web server always received it. To accomplish this, data packages would first be saved locally on the device. A separate thread in the background would periodically bundle all local data packages together and send it as a batch to the web server. The web server would then do some basic authentication on the data packages in the batch, save each package, and then return the results back to the game. If there were any issues along the way, the game would try to send the affected data packages again at the next batch transfer; otherwise, the data packages were flagged as saved and removed from local storage.

While this design could work to make a reliable data storage system, it was decided it would require more time than we could invest without a significant gain over a simpler, less reliable system. The simple design simply avoids storing the data locally with a background thread running to send it off in batches. Instead, data packages are instantly sent off to the web server as soon as a level is completed. If there is no Internet connection or some other kind of error, the data is lost and will not be saved on the web server. The chance of losing data could be a negative point of this design, but when one considers that the average level completion time is about 5 seconds, and that we expect users to be playing at least several levels per game session, losing some data packages periodically due to rare issues is acceptable. In our tests very little data has actually been lost and data loss only occurred when the player did not have an active Internet connection at the time the level was completed.


## 7. Data Analysis
The preliminary results of our project will be discussed to get an intuition if we are on the right track for studying how people learn probability distributions in games. Our initial analysis focuses on the dataset obtained from the author because it has the largest amount of trials compared to other participants. A summary and discussion of the data from other participants follows afterward.

### 7.1 Reaction Time
Figure 4 displays the mean reaction time results (y-axis) over 500 trials (x-axis) for the dataset generated by the author. The Random trials are colored in blue while the A1 trials are red. The reaction times on the y-axis for this plot were computed by iterating the dataset with a sliding window of ten data points. Error bars were computed with the same procedure to obtain the standard deviation for each point.

| ![Figure 4. Reaction time vs. trials for Random and A1 game modes. This figure displays the reaction time (in seconds) over 500 trials with error bars for the data obtained from the author.](https://www.imberstudios.com/images/slvg/figure_2a.png) |
|:--:|
| Figure 4. Reaction time vs. trials for Random and A1 game modes. This figure displays the reaction time (in seconds) over 500 trials with error bars for the data obtained from the author. |

Our assumption is that as the number of trials increase there will be a greater gap between the Random and A1 trial reaction times. Initially both reaction times may be similar, but as a player implicitly learns the conditional probability behind A1 they will start to react faster to it because they will be able to predict better where the basket will be based on the location of the pillow. Thus, there should be a greater gap when compared to the Random trial reaction times over many trials. The Random reaction times may decrease as well due to motor skill increases with the game, but that should eventually plateau around an average reaction time. This is because the player can never truly predict exactly where the basket will always be in relation to the pillow.

These initial results do not conclusively show that there is a clear separation in the reaction times between Random and A1 when error bars are factored. There are two reasons this could happen, either the player did not learn the probability distribution or our method could not resolve the differences sufficiently. The answer is likely the later as the dataset was generated from the author, who had full knowledge of the distribution used in the A1 mode.

Nonetheless, there is a small difference between the two modes. Table 1 contains the mean reaction times and the standard deviations for the author’s dataset showing this small difference. A larger separation in the reaction times may be possible with better tuning of the game world that allows for finer control over the character. Providing a way for players to increase their character movement speed beyond what is currently allowed could achieve this. They should not be bottlenecked by artificial speed limits in the game, but instead by the limit of what they are physically capable of achieving.

### 7.2 Failure Rate
What the graph of the reaction times does not tell us is how many times a player failed a level because they missed a pillow, basket, or both. If any of those situations arise, we do not count the data towards our reaction time analysis since the analysis requires activating the stimulus (pillow) and correctly responding to it (reaching the basket).

| ![Figure 5. Failure rate for the Random and A1 game modes. This figure displays the failure rate of each game mode for the data obtained from the author after 615 trials.](https://www.imberstudios.com/images/slvg/error_percent.png) |
|:--:|
| Figure 5. Failure rate for the Random and A1 game modes. This figure displays the failure rate of each game mode for the data obtained from the author after 615 trials. |

Figure 5 shows the rate of failure for each game mode. In the Random mode a player can never exactly know where the basket will be, so we expect its failure rate to be higher, which is what we observe. One point to note in this analysis is that we count missing the pillow, basket or both as a failure. Ideally, we would like to only know if the player just missed the basket because obtaining the pillow and then missing the basket means the player was unable to predict its location (i.e. they did not likely know the distribution behind the placement of the basket). Just missing the pillow means the player failed the motor learning phase, which should not count against whether that person learned anything about the probability distribution. Fortunately, distinguishing between these two types of failures is a simple enhancement that can be added to our data capture process in the future.

If we can measure whether the player missed only the basket we might see the failure rate drop for the A1 mode, which would help strengthen our assumption. If this drops significantly, then that would tell us that most of the prior failures likely occurred from the player failing to activate the stimulus, which is acceptable and is not counted in the analysis for learning the distribution.

### 7.3 Other Participants
Six people outside of the project were invited to participate in playing the game to obtain data about their performance. Most of the participants had about two to three months to participate before the data was analyzed. Of those invited, four participated.

The goal was to get a set of data from different sources to confirm or deny our initial analysis. Basic instructions on how to play the game and the goals of the project were given. Ideally, we wanted at least 100 trials completed of each game mode per person. The actual results we received however were not quite as much as we had hoped. Of the four that participated, only one ran through more than 100 trials of the Random game mode, but only ran a little more than a dozen of the A1 game mode. It is noteworthy to mention that for all but one of the participants most of the trials were with the Random game mode and very few were with the A1 mode. We are not certain as to why this was the case, but one reason may be due to the placement of the buttons where the modes can be selected.

In Figure 6 we see the menu screen where the game modes can be selected after completing a level.

| ![Figure 6. Result screen with menu. This figure shows the position of the menu buttons when the results of a level being completed are displayed.](https://www.imberstudios.com/images/slvg/a1_test_complete_sample_1.png) |
|:--:|
| Figure 6. Result screen with menu. This figure shows the position of the menu buttons when the results of a level being completed are displayed. |

It may be that people are more drawn to press the top button as a reflex reaction when wanting to play another level. This could be a side effect of having a game with fast gameplay and people wanting to quickly restart a new level after they have completed one. If this is true, then a simple fix could be to randomize the order of the placement for the Random and A1 buttons when drawn on the screen, so that even if a person always presses the top button, it will alternate between the different modes.

Because there was insufficient data from the other participants to plot graphs we opted to highlight key points in tabular form. Table 1 summarizes the number of trials for each game mode and their mean reaction times.

Table 1. Number of Trials and Reaction Times for Participants
| Participant   | Random Trials | A1 Trials | Mean Reaction Time (Random) | Standard Deviation (Random) | Mean Reaction Time (A1) | Standard Deviation (A1) |
|---------------|---------------|-----------|-----------------------------|-----------------------------|-------------------------|-------------------------|
| Author        | 500           | 500       | 1.9520                      | 0.2269                      | 1.8679                  | 0.1921                  |
| Participant 1 | 147           | 16        | 2.0690                      | 0.3455                      | 2.4298                  | 0.6948                  |
| Participant 2 | 74            | 22        | 2.4916                      | 0.3010                      | 2.7147                  | 0.5439                  |
| Participant 3 | 51            | 7         | 2.7252                      | 0.7782                      | 2.8330                  | 0.7924                  |

## 8. Conclusion
In this project we created a design for a video game where the reaction times of a player’s responses to a probability distribution embedded within the game could be measured. This game was designed to be very simplistic in order to test our assumption that as a person learns a distribution in the game, they will have a faster reaction time to complete the game’s goal after activating a stimulus when compared to a random distribution of the same thing.

A secondary objective of our project was to attract more people to participate in experiments carefully designed as video games and we targeted Apple’s iOS platform to achieve this. Mobile device hardware features, such as accelerometers, were included in our design to improve the reaction times of players. We showed that several people were attracted to the idea of playing a game that also had a research angle tied to it.

Data collected in the game was sent over the Internet to our central database for analysis where a small difference in the reaction times between the A1 and Random game modes was observed. Better tuning of the game to allow finer controls over the character may allow us to expand upon this effect. An examination of the failure rates for each game mode was also discussed. Future work will expand upon our data collection process, by eliminating initialization period failures, to obtain a more accurate failure rate analysis.


## References
Lembcke, S. (2013). Chipmunk Physics. In *Chipmunk Game Dynamics*. Retrieved January 1, 2013, from http://chipmunk-physics.net.

Hunt, R., Aslin, R. (2001).Statistical Learning in a Serial Reaction Time Task: Access to Separable Statistical Cues by Individual Learners. *Journal of Experimental Psychology: General*, 130 (4). 658-680. American Psychological Association.
