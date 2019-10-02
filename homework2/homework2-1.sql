
/* 
1) ER Diagram Interpretation

----------- a -----------

1. All foxes have a weight.
TRUE

2. A hunter can kill a fox without the assistance of a dog.
FALSE

3. A dog can kill a bird.
FALSE

4. Hunters are animals.
FALSE

5. All animals are dead.
FALSE

6. A hunter can kill a fox with the assistance of at least one dog.
TRUE

7. All foxes are dead.
TRUE

8. A bird can be killed by many hunters.
FALSE

9. All birds are dead.
FALSE

10. Given a hunter it is possible to find the total weight of the animals he/she has killed.
TRUE

11. A bird can be a dog.
TRUE


----------- b -----------

Hunder(ID)
Animal(ID, Weight)
Bird(ID, Wingspan, HunterID*)
Fox(ID, Color, HunterID)
Dog(ID, Breed, Name, FoxID*)





 */
