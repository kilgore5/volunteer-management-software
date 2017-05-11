### Pseudocode for feature planning

## Each event should have a calendar viewable by :admins, :shift_managers, :event_clients

  # =>  Thinking React is perfect for this.  Load the whole event as one from Rails in JSON, render views in React / JS

# => Each event should have multiple days 
# => Each day should have a daytime (6AM - 5.59PM) and a nighttime (6PM - 5.59AM)
# => day/nightime should have a # of jobs, # of shifts, # shifts to fill

  # =>  Clicking into one or the other should transition to a full view of that timeperiod
    # => Should show all jobs, # of shifts for each jobs, and # remaining

      # => Clicking job should take you to shifts list, with dropdown of vols accepted.

        # => Choosing a vol should AJAX update the vols' shifts, and send them an email, also decreasing the number of shifts available