name "pythonapp"
description "Sets up Python, Pip, and Virtualenv. Also installs img libs."

run_list(
  "recipe[bbox::python]"
)
