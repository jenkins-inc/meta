#!/usr/bin/env groovy
// Usage: update.groovy ACCOUNT NUM
//
//  Obtain a Nth tweet of the specified user account
@Grab('org.twitter4j:twitter4j-core:4.0.4')
import twitter4j.*;

def twitter = TwitterFactory.getSingleton();
def r = twitter.getUserTimeline(args[0], new Paging((args[1] as int) % 100, 1));
println r[0].text;

