{-
- Name: Palcu Liana Daniela
- Number: 117106643
- Assignment: 02.
-}

--This assignment presents a mutual recursion solution using only : and [].

main :: IO ()
main = putStrLn (show (paint_interior_bricks colours walls))
    where colours = [0,1,2]
          walls = [[3],[3,3],[3,3,3],[3,3,3],[3,3,3,3,3],[3,3,3,3,3,3]]


paint_interior_bricks :: Num a => [a] -> [[a]] -> [[a]]
--in this case I do not have walls, so I return an empty list 
paint_interior_bricks _ [] = []
--in this case I do not have colors, so I return the list of walls 
paint_interior_bricks [] walls = walls
--in this case I call an auxiliar function which it will help me to paint the walls
paint_interior_bricks colors walls = paint_walls colors colors walls

--paint_walls takes three arguments, a list of original colors, a list of colors/remained colors after I finish
--to paint a wall and a list of walls which will be painted
paint_walls :: Num a => [a] -> [a] -> [[a]] -> [[a]]
--in this case I don't have walls in the list and I return an empty list
paint_walls initial_colors _ [] = []
--in this case I call the function paint_the_wall to begin to paint the walls
paint_walls initial_colors colors (wall:walls) = paint_the_wall initial_colors colors wall [] [] walls True

--paint_the_wall function takes a wall and color it
--this function takes following parameters:
--initial-colors is the original list of colors
--colors is the list of colors using to paint the wall
--wall is the wall which will be painted
--colored_wall is the painted wall
--final_wall is the wall which will be concatenated to final list of painted walls
--walls is a list of lists(walls) which is used to know the wall which will be painted
--bool variable is used to color only in the interior of the list without the first or the last element
 
paint_the_wall :: Num a => [a] -> [a] -> [a] -> [a] -> [a] ->[[a]] -> Bool -> [[a]]
--in this case I finish to reverse the colored_wall list and I concatenate the final_wall list to the list
--of painted walls
--I call the function paint_walls to paint the remained walls with the remained colors in this point
paint_the_wall initial_colors colors [] [] final_wall walls _ = final_wall : paint_walls initial_colors colors walls
--in this case I finish to paint the bricks but they are don't in correct order, so that in the final_wall list
--I will put the bricks in their normal order by taking every element from the  colored_wall and append it to 
--final_wall list
--the empty list wall tells us that we are in this case 
paint_the_wall initial_colors colors [] (cw:colored_wall) final_wall walls _ = 
	paint_the_wall initial_colors colors [] colored_wall (cw:final_wall) walls False
--in this case I don't have colors in my list, colors is an empty list and I call the function paint_the_wall
--with initial_colors instead of colors, which it means that I refill the colors list  
paint_the_wall initial_colors [] wall colored_wall final_wall walls _ = 
	paint_the_wall initial_colors initial_colors wall colored_wall final_wall walls False
--in this case I have only one brick in the wall list and append it to colored_wall 
--[a] it tells us that we are in this case
paint_the_wall initial_colors colors [a] colored_wall final_wall walls _ = 
	paint_the_wall initial_colors colors [] (a:colored_wall) final_wall walls True
--in this case I take a color from the list of colors and append it to the colored_wall list
--in this case I paint the wall
--the value False for the Bool variable it tells us that we are in this case
--also, I take a brick from the wall to know how many bricks should be painted
paint_the_wall initial_colors (color:colors) (brick:wall) colored_wall final_wall walls False = 
	paint_the_wall initial_colors colors wall (color:colored_wall) final_wall walls False
--in this case I take the first brick from the wall and append it to the colored_wall list
--the value True for the Bool variable it tells us that we are in this case
paint_the_wall initial_colors colors (brick:wall) colored_wall final_wall walls True = 
	paint_the_wall initial_colors colors wall (brick:colored_wall) final_wall walls False
