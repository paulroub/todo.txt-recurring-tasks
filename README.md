An add-on for Gina Trapani's [todo.txt][todotxt] script, allowing the automatic addition of
recurring tasks to the todo list.

Once installed, the `todo.sh recur` command should be run from a `cron` job (or other scheduler), once a day.  Any tasks applicable to
the current date will be appended to the todo list (if they're not already present).

The recurring tasks are pulled from a `recur.txt` file, living in the same directory as `todo.txt`.  Each line in `recur.txt` has
the syntax:

    [week[,week ...] ] day : task
    
or

    daily: task    

Where:

- `week` is an optional list of weeks - "first", "second", "third", "fourth", "fifth" or "last".  Weeks are separated by
commas __only__ (no spaces).
- `day` is __one__ of "monday", "tuesday", "wednesday", "thursday", "friday", "saturday" or "sunday".  If a task needs to happen
on two different days of the week, you'll need two lines.
- `task` is anything that might appear in a [todo.txt][todotxt] task, including priority, contexts or projects.  Do *not* include
an added-on date, however.

## Examples:

    sunday: (A) Weekly review of projects list
    monday: Take out the trash @home
    last saturday: Apply the dog's flea medicine
    first,third friday: Collect and file expenses
    daily: run the dishwasher

Note that the add-on attempts to be smart about things, so if you ran this on a Sunday when `todo.txt` already contained:

    (B) Weekly review of projects list @home

It would notice the task with the same text (ignoring priority, context, project) and add nothing.

## Installation:

See the general [Creating and Installing Add-Ons][installing] documention to learn where and how to install the `recur` script.

If you'd rather not use the monolothic `recur` script, you can instead copy and rename `todo-recur.pl` and install the `lib` directory's contents in the
Perl library directory of your choice.


[todotxt]: https://github.com/ginatrapani/todo.txt-cli "A simple and extensible shell script for managing your todo.txt file."
[installing]: https://github.com/ginatrapani/todo.txt-cli/wiki/Creating-and-Installing-Add-ons
