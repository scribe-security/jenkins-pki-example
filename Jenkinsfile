node {
  withEnv([
    "PATH=./temp/bin:$PATH",
    "LOGICAL_APP_NAME=PKI-Sign-demo-project",
    "APP_VERSION=1.0.1",
    "AUTHOR_NAME=John-Smith", 
    "AUTHOR_EMAIL=jhon@thiscompany.com",
    "AUTHOR_PHONE=555-8426157",
    "SUPPLIER_NAME=Scribe-Security",
    "SUPPLIER_URL=www.scribesecurity.com",
    "SUPPLIER_EMAIL=info@scribesecurity.com",
   "SUPPLIER_PHONE=001-001-0011"
   
  ]) 
   {
    stage('install') {
      cleanWs()
      sh 'curl -sSfL https://get.scribesecurity.com/install.sh | sh -s -- -b ./temp/bin -D'
    }
    
    stage('checkout') {
            sh 'git clone -b main --single-branch https://guycherno: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@github.com/scribe-security/jenkins-pki-example.git'
            sh 'cd jenkins-pki-example; docker build -t pki-test -f ./orig-Dockerfile .'
     }
    
    stage('bom-git') {
      withCredentials([
        usernamePassword(credentialsId: 'scribe-production-auth-id', usernameVariable: 'SCRIBE_CLIENT_ID', passwordVariable: 'SCRIBE_CLIENT_SECRET'),
        certificate(credentialsId: 'sign-cert', keystoreVariable 'SIGN_KEY')
      ]) 
      
      {
        sh '''
          cat $SIGN_KEY|more
          cp jenkins-pki-example/.valint.yaml . 
          valint bom git:jenkins-pki-example \
            -o attest \
            --context-type jenkins \
            --output-directory ./scribe/valint \
            -E -U $SCRIBE_CLIENT_ID -P $SCRIBE_CLIENT_SECRET \
            --app-name $LOGICAL_APP_NAME --app-version $APP_VERSION  \
            --author-name $AUTHOR_NAME --author-email AUTHOR_EMAIL --author-phone $AUTHOR_PHONE  \
            --supplier-name $SUPPLIER_NAME --supplier-url $SUPPLIER_URL --supplier-email $SUPPLIER_EMAIL  \
            --supplier-phone $SUPPLIER_PHONE \
            -f '''
      }
    }

    stage('bom-image') {
      withCredentials([
        usernamePassword(credentialsId: 'scribe-production-auth-id', usernameVariable: 'SCRIBE_CLIENT_ID', passwordVariable: 'SCRIBE_CLIENT_SECRET')
      ]) {
        sh '''
          valint bom pki-test:latest \
            -o statement \
            --context-type jenkins \
            --output-directory ./scribe/valint \
            -E -U $SCRIBE_CLIENT_ID -P $SCRIBE_CLIENT_SECRET \
            --app-name $LOGICAL_APP_NAME --app-version $APP_VERSION  \
            --author-name $AUTHOR_NAME --author-email AUTHOR_EMAIL --author-phone $AUTHOR_PHONE  \
            --supplier-name $SUPPLIER_NAME --supplier-url $SUPPLIER_URL --supplier-email $SUPPLIER_EMAIL  \
            --supplier-phone $SUPPLIER_PHONE \
            -f '''
      }
    }

  }
}
