# BALLET POSITIONS(2017-2018)


## StoryBoard
  Loren is an Irish girl who likes to dance. She began to dance recently and this video shows the first movements she learnt during her first lessons classes.She is very shy and she tries to make her first movements to be perfectly but not always she can. In her back is her teacher who taught her these movements. Together they try to make a video to show the progress that Loren has made.


## Lighting
  **3-point lighting** - One point of light is represented by the key light in the left part, fill light in the right part and the rim light in the back.
  **Environment light** - I used white option and for the value of energy I choose 0.140.


## Material 
  I used different materials for the head, body, hands, foots, hair and the dress.


## Texturing
  **UV Image texturing** - I applied UV texturing on my model. I used two images for this. One image for the head, to model the face and one image for the body to represent the skin.\
  **Bump mapping** - I created bump mapping on the round portion of the floor where the ballerina stays. I applied first an image then I used the normal option to create this effect.\
  **Procedural texturing** - I applied this type of texturing on the dress. I choose the Voronoi texturing.


## 3D Text 
 I included also 3D Text. "Loren" is the name of the ballerina. I applied an image on the 3D text.


## AVATAR
  I build the model from just a simple cube. I followed a tutorial about this on the WikiBooks Noob/Pro. From the cube I modeled the body and then I extrude to make the arms, the legs and the head. 


## Armature - Rigging, Skinning and Inverse Kinematics
  For the character animation I used Armature. Armature is made from the bones, each bone has a corresponding name. Also beside the bones which build the skeleton, I used other bones which control the body, for example for the hand I used a target and also for the foot. Also I included the elbow and the knee(poll target).I used the root bone to control all the body. I applied Inverse Kinematics for the CalfRight bone and CalfLeft bone .Also for these bones I applied different constraints: move only to x axe and the angle to be between 0 and 180. The same thing I have done with the SubArmRight and SubArmLeft.


  For the human I applied two modifiers: Mirror(to build the character symmetrically)  and Subsurf(Catmull-Clark - subdivision).


## COMPOSITING
  I composite my CG with the movie in my scene. In composition I included: 
    ** Color Correction - I made the skin to look more natural.\
    ** Alpha channel - I merged the video with my character.\
    ** different types of filters - Bokeh Blur, Glare, Dilate/Erode. I used Glare for the human and Bokeh Blur and Dilate/Erode for the movie because I wanted to emphasize the movements of my character.Also I made the movie to be black and white and the character color to put into light my character.(ballerina). 


## Cloth Simulation 
  I made a dress from a simple polygon then I applied cloth simulation on this. I selected a group of vertices from the dress, I assigned different weights to these vertices. This group I used for pinning, which means that the dress it doesn’t move from there. Also I applied self collision and collision with the body. It isn’t the perfect cloth simulation, it has some issues but I try to see how the effect looks because I was just curious. 


## Hair 
  For the character I made hair using the particle option, and from that I selected Hair option. I used particle edit mode to comb the hair and to make it to look better.

  I rendered end exported the animation as a 720x480p movie (use h.264 codec.). The result was really good. I like some moves that my character does, they look very naturally. Also I love the cloth simulation effect which I find very interesting and very challenging. As I said, it isn’t the perfect effect, but I tried. Probably, I could work more to avoid strange deformations which appears to the joints. But, as my first animation it look very good and it was a challenge for me to do this and I have a lot of fun while I learning interesting things.
