# reliability-test-sample

Reliability assessment based on the data of the prototype testing

Menu structure of the control program (programma_01.m)

![image](https://user-images.githubusercontent.com/111389991/227302303-d199b18f-19d1-42e6-870d-adf744cc0b26.png)

Program-menu Programma_01.fig

![image](https://user-images.githubusercontent.com/111389991/227305194-a885aaa0-88fc-49f2-8838-ebd9477bd0ed.png) 

# Programs for calculating reliability according to the binomial classical model (programma_1001.m (_1002.m)).
Programs programma_1001.m (_1002.m) provide reliability estimates according to the methodology.
The interface (dialog box) is opened by calling the program programma_1001.m. Then "pressing" the cursor on the "Run" button the interface opens

![image](https://user-images.githubusercontent.com/111389991/227307016-46808f8b-1063-4675-811a-fae23ef2fbc5.png)

The initial data for the calculation is entered by the user from the keyboard in the source data window: 

- the number of cycles n =, 

- the number of failures d=, 

- the value of the confidence probability gamma =     .

After "clicking" the "Solution" button with the cursor in the windows of the calculated PN (P= , T= , P_= , T_= ) calculation results appear

![image](https://user-images.githubusercontent.com/111389991/227307462-076548f4-296c-4ba1-925d-ec4c83f4b3cd.png)

The program progamma_400.m provides reliability estimates, prediction of reliability values based on the results of testing and testing, and predictive calculation of the additional number of response cycles required to achieve the required reliability values
Working with the program programma_400.m is built using an interface consisting of a number of dialog boxes.
The opening of the first dialog box "Choosing a solution option" is performed by calling the program progamma_400.m. After opening the program progamma_400. m by "pressing" the cursor on the "Run" button  the interface opens.

![image](https://user-images.githubusercontent.com/111389991/227308577-496d70b8-318a-4e5b-bda9-631b6d81a496.png)

The user selects the source data option for the calculation: dk=1 – the user's source data is entered, dk=2 – the source data of the example embedded in the program is entered. The selected solution option (1 or 2) is entered into the window from the keyboard with the "click" of the "ok" button.
	If the number 2 is entered into the window, the program performs the calculation according to the example data and automatically displays the intermediate and final calculation results on the screen. If desired, the source data of the example in the program can be reprogrammed.
  
 If the number 1 is entered into the window, the program displays the dialog boxes "General data entry" and "Series data entry", filled in by the user, sequentially on the screen
 
![image](https://user-images.githubusercontent.com/111389991/227328939-180958ab-9fb1-4558-a44b-1801d6f37b84.png)
![image](https://user-images.githubusercontent.com/111389991/227328995-a159ce34-783b-402e-959f-1fe1c7fc550a.png)

The initial data, structured in accordance with the provisions of the methodology, is entered by the user from the keyboard. 

The corresponding windows are filled in:

v - the number of improvements;

mc1 - number of initial test series (mc1≥2); 

mc2 is the number of test series counted from the last one in reverse order (mc2≥2); 

γ is the value of the confidence probability;

ni - the number of tests in the i-th series; 

mi - the number of failures in the i-th series; 

ci is the number of reasons for failures eliminated by the i-th revision.

Data entry in each window ends with the "click" of the "ok" buttons.

The program performs the calculation based on the entered data and automatically displays the intermediate and final results of the calculation in digital and graphical terms. To illustrate, the results of solving the reliability assessment problem according to the data of the sample program are given.

![image](https://user-images.githubusercontent.com/111389991/227330906-426cd780-ba44-46f0-ac6b-f1e7395c5536.png)

![image](https://user-images.githubusercontent.com/111389991/227331065-a57dc9b0-5012-499b-b2b3-1182b5082239.png)

![image](https://user-images.githubusercontent.com/111389991/227331375-6c1bce0c-d717-4f01-9291-0f31506f486b.png)

When choosing the task of predicting reliability values based on the results of testing and testing (dk=1), the program suggests using the following dialog box to enter the value "Deltan" ∆n to calculate the predicted reliability values

![image](https://user-images.githubusercontent.com/111389991/227332357-a33903cd-f5bd-4638-980c-9f4366c3bb3e.png)

![image](https://user-images.githubusercontent.com/111389991/227332545-e7975920-c705-4d1b-9f0c-7da5dd7dd709.png)

The result of the calculation is displayed using the window "The result of the forecast calculation, option one. Fig. shows the results of the calculation according to the data of the sample program and the user-defined value of the value "Delta n" (∆n=35).
When choosing the task of calculating the additional number of shots (firing cycles) required to achieve the required values of PN (dk=2), the program suggests using the next dialog box that opens to enter the value Pexpr (reliability value ("P" _"Pr" )).

![image](https://user-images.githubusercontent.com/111389991/227333480-4e9b3aaf-1ba2-4887-a7d7-a545f9490ec3.png)

![image](https://user-images.githubusercontent.com/111389991/227332489-9936c44e-926f-4209-abeb-18260259f0f7.png)

# Program for calculating reliability based on a recurrent model (programma_100.m)

The first dialog box "Data Entry" is opened by calling the program rgodgamma_100.m. After opening the program rgodgamma_100. m by "pressing" the cursor on the "Run" button the "Data Entry" interface opens, providing the initial input of the source data.
The initial data, structured in accordance with the provisions of the methodology, is entered by the user from the keyboard. The corresponding windows are filled in:

v – the number of test series (in this case (v–1) - the number of improvements); 

n1 - the number of trials in the 1st series; 

n2 - the number of tests in the 2nd series; 

d1 - the number of failures in the 1st series; 

d2 - the number of failures in the 2nd series; 

γ - the value of confidence probability. 

The input of the listed data ends with the "click" of the "ok" button.

![image](https://user-images.githubusercontent.com/111389991/227334359-1be89ecc-ceff-4483-a770-13a791158509.png)

![image](https://user-images.githubusercontent.com/111389991/227334391-31dd1ef4-5850-475e-b8da-c0d67c866826.png)

With each input of the initial data through the interface "Input n and d" sequentially by test series (from the third to the last series), the program opens windows with graphs of polygon dependencies of PN values, demonstrating the dynamics of changes in the reliability of the system during testing and testing as a function of the number of improvements made. One of these demonstrations is shown in the figure. 
On each of these screens, the program simultaneously places a dialog box with a suggestion to continue the dialog.

![image](https://user-images.githubusercontent.com/111389991/227334662-27b21303-a20e-4712-8248-b4c0c60df586.png)

![image](https://user-images.githubusercontent.com/111389991/227334706-a9f6e2d2-c003-48e4-bfa9-4660e6316ee9.png)

![image](https://user-images.githubusercontent.com/111389991/227334754-de3c879b-5f6c-4334-be27-e63a5bcdc403.png)

At the end of input of the initial data, the user is asked to choose the type of graphical representation of the calculated dependence of the change in the reliability of the system during testing and testing as a function of the number of tests. The Graph View dialog box offers several options for representing the graph: in the form of a polygon, in the form of a step dependence. 	
As an example, a window with a graphical representation of changes in the reliability of the system during testing and testing as a function of the number of tests in the form of a stepwise dependence is given.
Complete results of solving the problem of calculating the reliability estimates of the system (P ,▁P , T ,▁T) according to the data of testing and testing (according to the user's initial data), the program places in a summary table. An example of a summary table of calculation results is shown in the figure

# The program for calculating reliability according to the model "differentiated by types of failures" (pro-gramma_201.m).

The corresponding upper row windows are filled in: 

n - the total number of tests (shots, cycles);

m1- the total number of recoverable failures;

m2 – the total number of non-recoverable failures; 

γ – confidence probability.   

Having data on the number of types of failures, data on the distribution of tests and failures by types of failures, data on modifications, the window "Number of tests before modifications for type I failures (n1)" is filled with the values of the number of tests for each type of failures before modifications are carried out on them. At the same time, the data are arranged in a certain order according to the types of failures; the data for each type of failures are separated by a "space". 
In the window "Number of failures of the i-th type before modifications (m1i)", data on the values of the number of failures for each type of failures before modifications are carried out on them are located. In this case, the data are arranged in the accepted order according to the types of failures, the data for each type of failures are separated by a "space"

![image](https://user-images.githubusercontent.com/111389991/227335856-1774aeea-4e75-47a7-856e-9cb1fbd175d4.png)

The window "Number of tests after modifications for type I failures (n2)" contains data on the values of the number of tests for each type of failures after modifications are carried out on them. In this case, the data are arranged in the accepted order according to the types of failures, the data for each type of failures are separated by a "space".
After entering the listed data, the user opens the "Calculation with the number of tests" window and selects with the cursor one of the three proposed options for setting the equivalent test volume (n eq) to ensure the calculation of interval reliability estimates

![image](https://user-images.githubusercontent.com/111389991/227335925-1cd77bdd-9ad2-4c23-8153-c8027d16e3ac.png)
