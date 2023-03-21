## start by turning this folder into a git/github repository
   1.  inside the root of the project type:
   
   ` git init `

   1. this will create a **local** repository placing you on the 'master' branch
   2. commit the generated files
   3. publish this to your github repo
   `git remote add origin https://github.com/${NAME}/${REPO}.git`

    or if using SSH

    `git remote add origin git@github.com:${NAME}/${REPO}.git`

   `git push -u origin master`