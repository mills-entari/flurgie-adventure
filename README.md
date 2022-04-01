# flurgie-adventure
Game Learning project in the Machine Learning Laboratory at the University of Hawaii at Manoa.

Link to report on project: [Statistical Learning in Video Games](https://goo.gl/kzFBbE)


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

![Figure 1. Light box device illustration from Hunt & Aslin (2001). This figure illustrates the light box with eight buttons used in their 3rd experiment and a sequence of how the buttons could light up.](https://www.imberstudios.com/images/slvg/light_box_2.png)

(Figure 1. Light box device illustration from Hunt & Aslin (2001). This figure illustrates the light box with eight buttons used in their 3rd experiment and a sequence of how the buttons could light up.)

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
