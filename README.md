# Cloud Memory

[![Build Status](https://travis-ci.org/krasnoukhov/cloudmemory.png?branch=master)](https://travis-ci.org/krasnoukhov/cloudmemory)

### From memorabilia to ephemera 

The common photo album has significantly transformed its memory function since its invention. Instagram, the latest incarnation of a personal photo album, produces an enormous amount of personal imagery, formally identical to that of the traditional photo albums. But today these photographs have evolved from "ça a été" into "what's going on". Photos taken aren't supposed to preserve memories – they are meant to be glanced at and then to flow away with the stream.   

A photo album was intended to be a private experience, shared by its owner with people of their choice. An Instagram photo is meant to be shared, with such built-in tools as tags and geotags. What if in the age of cloudified data our personal photographs have also formed a "cloud memory"?  I wanted to explore the idea that in the world where everything has been photographed, one might not need to take a picture, but just pull it out from a "cloud" of shared personal imagery. Paraphrasing Lacan, with these photos one sees him/herself "in The Other's Other". Personal becomes shared and then, anonymous.

"Cloud Memory" consists of 2 parts: a physical object that is an old photo album found at a flea market in Paris and a website. The album was empty, with only  captions and 2 original photos left in it. I filled it with Instagram photos found by tags and geotags corresponding to the captions, placing them in the "traditional" photography context.
The website features 5 pages of the album where each photo is, in fact, a stream generated with a specific tag or location, according to the original caption. Every time you open the album, you see new pictures. Instagram photos can't get old, they can only go away.  


#### Tech description

Written in [Ruby](http://www.ruby-lang.org/) and [CoffeeScript](http://coffeescript.org/) using awesome [cuba](https://github.com/soveran/cuba), [sprockets](https://github.com/sstephenson/sprockets) and [slim](http://slim-lang.com/). Tested with [cutest](https://github.com/djanowski/cutest) and [capybara](https://github.com/jnicklas/capybara).
