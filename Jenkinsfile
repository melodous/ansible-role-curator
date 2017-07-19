node {


    currentBuild.result = "SUCCESS"

    try {

       stage('Checkout'){

          checkout scm
       }

       stage('Molecule syntax'){

         sh 'make syntax'

       }

       stage('Molecule create'){

         sh 'make create'

			 }

       stage('Molecule converge'){

         sh 'make converge'

			 }

       stage('Molecule idempotence'){

         sh 'make idempotence'

			 }

       stage('Molecule verify'){

         sh 'make verify'

       }


       stage('Molecule Delete'){

         sh 'make delete'

       }
    }
    catch (err) {

        currentBuild.result = "FAILURE"

            mail body: "project build error is here: ${env.BUILD_URL}" ,
            from: 'xxxx@yyyy.com',
            replyTo: 'yyyy@yyyy.com',
            subject: 'project build failed',
            to: 'zzzz@yyyyy.com'

        throw err
    }

}

