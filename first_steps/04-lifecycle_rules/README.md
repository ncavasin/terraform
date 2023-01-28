# Lifecycle rules

- ``create_before_destroy``: create the resource first and then destroy older one
- ``prevent_destroy``: no resource is destroyed.
- ``ignore_changes``: ignore changes to Resource (for a specific tag or all Resources)