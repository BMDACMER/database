# Ratcontrol Schemas

This schema contains data needed by the application ratcontrol to handle
traffic control settings for DERP infrastructure.

## Making alters

To create an alter you must have [Schema Tool][st] installed locally. If you
haven't used Schema Tool before it's worth reading the entire readme to
familiarize yourself. Alter the `config.json` file from this repo as necessary
but do not commit it.

Be sure to see the wiki pages for both:
- [conventions for database changes][dbc], and
- [the PostgreSQL coding standards][pgs].

The typical workflow for making an alter is:

1. Create a new up/down alter file pair with `schema new`.
2. Manually complete the up/down files with the proper logic to enact and
   reverse your alter, respectively.
3. Test your alter file pair on a testing database that is up to date with the
   current schemas. (See `schema up --help`.)
4. Create a DERP ticket pertaining to your alter.
5. Commit your alter to a feature branch named for your DERP ticket. Your
   commit message should follow the form "DERP-####: Your commit message". Note
   that these conventions come from the aforementioned conventions wiki page.
4. PR your changes to master and create a DBA PR review ticket per the
   conventions wiki page.
5. Once your PR is approved, merge and then create one DBA alter ticket per
   target environment following the conventions wiki page.

[dbc]: https://corpwiki.appnexus.com/pages/viewpage.action?spaceKey=engineering&title=How+to+Make+Database+Changes+as+a+Developer
[pgs]: https://corpwiki.appnexus.com/pages/viewpage.action?spaceKey=engineering&title=Postgres+Coding+Standards+and+Guidelines
[st]: https://github.com/appnexus/schema-tool
