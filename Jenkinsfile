pipeline{
	agent any
	stages {
		stage('Lint HTML'){
			steps {
				sh 'tidy -q -e index.html'
				sh 'hadolint Dockerfile'
			}
		}

		stage('Upload docker Image')
		{
			steps{
				sh 'docker build . --tag=liarachelian/capstone'
				withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'passwd', usernameVariable: 'username')]) {
					sh 'docker login -u $username -p $passwd'
					sh 'docker push liarachelian/capstone'
				}
			}
		}

		stage('deploy in kubernetes')
		{
			steps{
				withAWS(credentials: 'udacity-capstone', region: 'us-west-2')
				{
					sh 'aws eks --region=us-west-2 update-kubeconfig --name devops_capstone'
					sh 'kubectl apply -f deployment.yml'
				}
			}
		}
	}
}