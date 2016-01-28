# ctags.rake - Rake task to create ctags for a Rails application
# and also including Ruby and Gem signatures
#
# Requires exuberant-ctags to be in $PATH

desc "Regenerate tags (CTAGS)"
task :ctags do
    puts " * Regenerating Tags"
    excludes = %w{
         .git
         app/views/
         coverage
         test/coverage
         doc
         features
         log
         tmp
    }
    excludes_options = excludes.map{
        |e| "--exclude=#{e}"
    }.join(' ')
    system("ctags -V -a -R #{
         excludes_options
           } * `gem environment | grep INSTALLATION | awk '{
         print $4
         }'`/*")
end
