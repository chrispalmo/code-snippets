# Configure Git to globally ignore scratch.md

Great for quick n' dirty transient note taking in `~/any_project/scratch.md` without needing to add it to the project `.gitignore`.

From https://calebporzio.com/keep-notes-about-your-laravel-projects-scratch-md

```
echo 'scratch.md' > ~/.gitignore_global
git config --global core.excludesdfile ~/.gitignore_global
```

