- 1. Breaking systems into subsystems
- 2. Testing
- 3. Deployment
- 4. Documentation
- 5. Scaling
- 6. Security

Code needs to be organized into modules, packages, classes and methods.

1. Determine what subsystem make systems. Make logical components that work together to 
solve problem. test individual subsytem (smaller pieces of code) ex. auth system, messaging system. reduce complexity in code base by splitting systems.
Ex. mobile game - auth, messaging, ui, back end system, achievement system, score system, 
Determine what sub-systems have in the beginning of development 
Subsystem -> modules, classes and methods. 
2. testing -> how write code based on how test the code, manual, integraton, unit, database, backend, frontend, ui component testing -> what test and mock tests or live tests, not slow by testing as high quality test are slow, write code that is testable -> if complicated then cannot test in isolation. get more features and subsystems -> testing becomes important by running a single command - automated test ,   
3. deployment - how serve application/software. Ex. localhost -> take code and deploy so users access it. mobile or app . How deploy automatically or set intervals or push updates to users ? how give to users, emulate dev env to deployment env. how scale - deploy multiple systems or one system at a time.
4. Documentation - code base start simple and easy to understand, more important as code 
base larger -> if not view feature after a long time, new developers onboard on code base, 
doc for section ? doc for how to set codebase up ? doc for specific features or systems ?
doc for decent idea on what is going on, how they can set up and start adding to codebase.
5. scaling -> software used by 10000s of people and across geographic regions and languages. ex. Database reads/write - if write algo ie. O(n2) then way too costly instead of writing optimized algo that does in O(n) time. 
Code unable to scale as not deploy to multiple servers. 
6. security -> when have lot of seperate system - sync auth between all these systems and users have access to relevant system, rate limiting on database, auth for db for users, easily auth users, pwd where store ? -> auth system, verify users sign in who they are. 
ddos - hit api million times. 





