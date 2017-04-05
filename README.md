# interpretation
Allele (variant) interpretation model and API for ClinGen

# Viewing the documentation

```bash
bundle install # assumes a working ruby and bundle installation, gets all of the ruby dependencies
               # only needs to be done once (or when dependencies change)

bundle exec middleman # now you should be able to view docs in a browser
                      # at http://localhost:4567
```

# Updating examples
An extensive set of examples are being developed in a google sheets document that is tranformed to json for display/documentation.

The partially-transformed example data gets stored in `data/flattened` with each sheet being stored as a separate JSON file. To regenerate this "flattened" data:

```bash
# from within the working directory...

rm data/flattened/* # this step is necessary to make sure the prior generated data is removed
bundle exec ruby ./get_examples.rb
```

Then you can `git diff` to see changes since the last time the sheets data was updated in the repository. If you like them, you can `git add data/flattened` and `git commit`...

Or you can run `bundle exec ruby reformat_examples.rb` to get a hierarchical view of the data (with appropriate links among data items).
