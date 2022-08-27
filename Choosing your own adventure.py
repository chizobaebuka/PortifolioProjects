name = input("Type your name: ")
print("Welcome", name, "to this adventure")

answer = input("You are at a Crossroad, you can go either left or right. Which way would you like to go? ").lower()

if answer == "left":
    answer = input("You have reached a river, you can walk around it, paddle a boat or swim across. Type walk to walk around it and Swim to swim across: ")

    if answer == "swim":
        print("You swam across and you've been eaten by an alligator. ")
    elif answer == "walk":
        print("You walked for many miles, and ran out of water and lost the game. ")
    elif answer == "paddle a boat":
        print("You paddled a boat. Congrats you won! ")
    else:
        print("Not an option, You lose! ")

elif answer == "right":
    answer = input("You've arrived at a Zombie land, do you want to run back or pick up a Gun and kill them(Run/Gun)? ")
    
    if answer == "Run":
        print("You run back to the Crossroad. You lose! ")
    elif answer == "Gun":
        answer = input("You pick up the gun, do you shoot the zombies (yes/no)? ")

        if answer == "yes":
            print("You shoot the zombies. You win!")
        elif answer == "no":
            print("You don't shoot the zombies on time and you lose! ")
        else:
            print("Not a valid option. You lose!")  

    else:
        print("Not an option, You lose! ")


else:
    print("Not an option. You lose! ")

print("Thank you for trying", name )