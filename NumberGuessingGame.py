#Choosing a random number between 1 and 100
from random import randint

EASY_LEVEL_TRIES = 10
HARD_LEVEL_TRIES = 5

#Create a function to check the users guess against the actual number
def check_answer(guess, answer, tries):
    if guess > answer:
        print("Too high")
        return tries - 1
    elif guess < answer:
        print("Too low")
        return tries -1
    else:
        print(f"You got it! The answer is {answer}")

#make a function to set the difficulty
def set_difficulty():
    level = input("Choose a difficulty. Type 'easy' or 'hard': ")
    if level == 'easy':
        return EASY_LEVEL_TRIES
    else:
        return HARD_LEVEL_TRIES

def game():
    #Welcome statement
    print("Welcome to the Number Guessing game!")
    print("I'm thinking of a number between 1 and 100.")
    answer = randint(1, 100)
    print(f"The correct answer is: {answer}")

    tries = set_difficulty()

    #Repeat the guessing function if they got it wrong
    guess = 0 
    while guess != answer:
        print(f"You have {tries} attempts remaining to guess the number")
        #Let the user guess a number
        guess = int(input("Make a guess: "))
        #Tracking the number of tries and reducing it by 1 if gotten wrong
        tries = check_answer(guess, answer, tries)
        if tries == 0:
            print("You've run out of guesses, you lose!")
            return
        elif guess != answer:
            print("Guess again.")    
game()