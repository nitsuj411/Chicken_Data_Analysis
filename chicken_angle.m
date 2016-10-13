function angle=chicken_angle(P1,P2,P3)
angle=acos(dot((P2-P1),(P3-P2))/(norm(P2-P1)*norm(P3-P2)));
