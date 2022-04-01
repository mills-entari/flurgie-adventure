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
