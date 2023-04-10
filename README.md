1.
ansible-playbook play.yml 

на экране будет показан пароль для первоначального входа в jenkins, нужно ввести его пожалуйста по адресу https://jenkins.example.com , установить рекомендованные плагины и создать первоначального пользователя
В корне лежит файл с именем Jenkinsfile , на основе него нужно создать:
  - Item - pipeline (напр., с названием s1)
  - credentials для nexus - логин и пароль (с ID "nexus" (NEXUS_CREDENTIALS = "nexus")) 
    (сейчас ./settings_nexus.sh создает jenkins/jenkins , так же можно задать своего пользователь в переменные USERNAME/PASSWORDNEW)
2.
ansible-playbook install_plugin_jenkins.yml --extra-var "user=1 password=1"
где user и password - креды от дженкинса (созданные на предыдущем шаге)


3. 
ansible-playbook run_pipeline.yml --extra-var "user=1 password=1 jobs=s1"
где job- это название пайплайна, созданного в веб интерфейсе. Лог выполненного пайплайна можно увидеть в корне проекта в файле check_result.log
