1.
ansible-playbook play.yml 
на экране будет показан пароль для первоначального входа в jenkins, нужно ввести его пожалуйста по адресу http://127.0.0.1:8080 , установить рекомендованные плагины и создать первоначального пользователя
В корне лежит файл с именем Jenkinsfile , на основе него нужно создать pipeline (напр., с названием s1)

2.
ansible-playbook install_plugin_jenkins.yml --extra-var "user=1 password=1"
где user и password - креды от дженкинса (созданные на предыдущем шаге)

3. 
ansible-playbook run_pipeline.yml --extra-var "user=1 password=1 jobs=s1 
где job- это название пайплайна, созданного в веб интерфейсе. Лог выполненного пайплайна можно увидеть в корне проекта в файле check_result.log

