pipeline{
	
	
	agent any
	stages {
		stage('Lint HTML'){
			steps {
				sh 'tidy -q -e index.html'
				
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
		
		stage('Setting configurations'){
			steps {
				withAWS(region:'us-west-2', credentials:'udacity-capstone') {
					sh 'aws eks --region us-west-2 update-kubeconfig --name kubeconfig'
			}
		}
	}	 
	 
	 	stage('Set kubectl context') {
			steps {
				withAWS(region:'us-west-2', credentials:'udacity-capstone') {
					sh '''
						kubectl config use-context arn:aws:eks:us-west-2:071739109446:cluster/udacity-cluster
					'''
				}
			}
		}

		
		stage('Create blue service') {
			steps {
				withAWS(region:'us-west-2', credentials:'udacity-capstone') {
					sh '''
						kubectl apply -f ./deployment-blue.yml
					'''
				}
			}
		}

		stage('Wait ') {
            		steps {
                		input "Change traffic?"
            		}
        	}

		stage('Create green service') {
			steps {
				withAWS(region:'us-west-2', credentials:'udacity-capstone') {
					sh '''
						kubectl apply -f ./deployment-green.yml
					'''
				}
			}
		}
     }
}
	
