include <../_lib/BOSL2/std.scad>

$fn = 24;

//path points coordinates (from a javascript program)
p = [
[20.625, 20.625],
[20.625, 41.875],
[
41.875,
41.875
],
[
41.875,
20.625
],
[
63.125,
20.625
],
[
84.375,
20.625
],
[
84.375,
41.875
],
[
63.125,
41.875
],
[
63.125,
63.125
],
[
84.375,
63.125
],
[
84.375,
84.375
],
[
63.125,
84.375
],
[
41.875,
84.375
],
[
41.875,
63.125
],
[
20.625,
63.125
],
[
20.625,
84.375
],
[
20.625,
105.625
],
[
41.875,
105.625
],
[
41.875,
126.875
],
[
20.625,
126.875
],
[
20.625,
148.125
],
[
20.625,
169.375
],
[
41.875,
169.375
],
[
41.875,
148.125
],
[
63.125,
148.125
],
[
63.125,
169.375
],
[
84.375,
169.375
],
[
84.375,
148.125
],
[
84.375,
126.875
],
[
63.125,
126.875
],
[
63.125,
105.625
],
[
84.375,
105.625
],
[
105.625,
105.625
],
[
126.875,
105.625
],
[
126.875,
126.875
],
[
105.625,
126.875
],
[
105.625,
148.125
],
[
105.625,
169.375
],
[
126.875,
169.375
],
[
126.875,
148.125
],
[
148.125,
148.125
],
[
148.125,
169.375
],
[
169.375,
169.375
],
[
169.375,
148.125
],
[
169.375,
126.875
],
[
148.125,
126.875
],
[
148.125,
105.625
],
[
169.375,
105.625
],
[
169.375,
84.375
],
[
169.375,
63.125
],
[
148.125,
63.125
],
[
148.125,
84.375
],
[
126.875,
84.375
],
[
105.625,
84.375
],
[
105.625,
63.125
],
[
126.875,
63.125
],
[
126.875,
41.875
],
[
105.625,
41.875
],
[
105.625,
20.625
],
[
126.875,
20.625
],
[
148.125,
20.625
],
[
148.125,
41.875
],
[
169.375,
41.875
],
[
169.375,
20.625
],
[
190.625,
20.625
],
[
211.875,
20.625
],
[
211.875,
41.875
],
[
190.625,
41.875
],
[
190.625,
63.125
],
[
190.625,
84.375
],
[
211.875,
84.375
],
[
211.875,
63.125
],
[
233.125,
63.125
],
[
233.125,
84.375
],
[
254.375,
84.375
],
[
254.375,
63.125
],
[
254.375,
41.875
],
[
233.125,
41.875
],
[
233.125,
20.625
],
[
254.375,
20.625
],
[
275.625,
20.625
],
[
275.625,
41.875
],
[
296.875,
41.875
],
[
296.875,
20.625
],
[
318.125,
20.625
],
[
339.375,
20.625
],
[
339.375,
41.875
],
[
318.125,
41.875
],
[
318.125,
63.125
],
[
339.375,
63.125
],
[
339.375,
84.375
],
[
318.125,
84.375
],
[
296.875,
84.375
],
[
296.875,
63.125
],
[
275.625,
63.125
],
[
275.625,
84.375
],
[
275.625,
105.625
],
[
275.625,
126.875
],
[
296.875,
126.875
],
[
296.875,
105.625
],
[
318.125,
105.625
],
[
339.375,
105.625
],
[
339.375,
126.875
],
[
318.125,
126.875
],
[
318.125,
148.125
],
[
339.375,
148.125
],
[
339.375,
169.375
],
[
318.125,
169.375
],
[
296.875,
169.375
],
[
296.875,
148.125
],
[
275.625,
148.125
],
[
275.625,
169.375
],
[
254.375,
169.375
],
[
233.125,
169.375
],
[
233.125,
148.125
],
[
254.375,
148.125
],
[
254.375,
126.875
],
[
254.375,
105.625
],
[
233.125,
105.625
],
[
233.125,
126.875
],
[
211.875,
126.875
],
[
211.875,
105.625
],
[
190.625,
105.625
],
[
190.625,
126.875
],
[
190.625,
148.125
],
[
211.875,
148.125
],
[
211.875,
169.375
],
[
190.625,
169.375
],
[
190.625,
190.625
],
[
211.875,
190.625
],
[
211.875,
211.875
],
[
190.625,
211.875
],
[
190.625,
233.125
],
[
190.625,
254.375
],
[
211.875,
254.375
],
[
211.875,
233.125
],
[
233.125,
233.125
],
[
233.125,
254.375
],
[
254.375,
254.375
],
[
254.375,
233.125
],
[
254.375,
211.875
],
[
233.125,
211.875
],
[
233.125,
190.625
],
[
254.375,
190.625
],
[
275.625,
190.625
],
[
275.625,
211.875
],
[
296.875,
211.875
],
[
296.875,
190.625
],
[
318.125,
190.625
],
[
339.375,
190.625
],
[
339.375,
211.875
],
[
318.125,
211.875
],
[
318.125,
233.125
],
[
339.375,
233.125
],
[
339.375,
254.375
],
[
318.125,
254.375
],
[
296.875,
254.375
],
[
296.875,
233.125
],
[
275.625,
233.125
],
[
275.625,
254.375
],
[
275.625,
275.625
],
[
275.625,
296.875
],
[
296.875,
296.875
],
[
296.875,
275.625
],
[
318.125,
275.625
],
[
339.375,
275.625
],
[
339.375,
296.875
],
[
318.125,
296.875
],
[
318.125,
318.125
],
[
339.375,
318.125
],
[
339.375,
339.375
],
[
318.125,
339.375
],
[
296.875,
339.375
],
[
296.875,
318.125
],
[
275.625,
318.125
],
[
275.625,
339.375
],
[
254.375,
339.375
],
[
233.125,
339.375
],
[
233.125,
318.125
],
[
254.375,
318.125
],
[
254.375,
296.875
],
[
254.375,
275.625
],
[
233.125,
275.625
],
[
233.125,
296.875
],
[
211.875,
296.875
],
[
211.875,
275.625
],
[
190.625,
275.625
],
[
190.625,
296.875
],
[
190.625,
318.125
],
[
211.875,
318.125
],
[
211.875,
339.375
],
[
190.625,
339.375
],
[
169.375,
339.375
],
[
169.375,
318.125
],
[
148.125,
318.125
],
[
148.125,
339.375
],
[
126.875,
339.375
],
[
105.625,
339.375
],
[
105.625,
318.125
],
[
126.875,
318.125
],
[
126.875,
296.875
],
[
105.625,
296.875
],
[
105.625,
275.625
],
[
126.875,
275.625
],
[
148.125,
275.625
],
[
148.125,
296.875
],
[
169.375,
296.875
],
[
169.375,
275.625
],
[
169.375,
254.375
],
[
148.125,
254.375
],
[
148.125,
233.125
],
[
169.375,
233.125
],
[
169.375,
211.875
],
[
169.375,
190.625
],
[
148.125,
190.625
],
[
148.125,
211.875
],
[
126.875,
211.875
],
[
126.875,
190.625
],
[
105.625,
190.625
],
[
105.625,
211.875
],
[
105.625,
233.125
],
[
126.875,
233.125
],
[
126.875,
254.375
],
[
105.625,
254.375
],
[
84.375,
254.375
],
[
63.125,
254.375
],
[
63.125,
233.125
],
[
84.375,
233.125
],
[
84.375,
211.875
],
[
84.375,
190.625
],
[
63.125,
190.625
],
[
63.125,
211.875
],
[
41.875,
211.875
],
[
41.875,
190.625
],
[
20.625,
190.625
],
[
20.625,
211.875
],
[
20.625,
233.125
],
[
41.875,
233.125
],
[
41.875,
254.375
],
[
20.625,
254.375
],
[
20.625,
275.625
],
[
20.625,
296.875
],
[
41.875,
296.875
],
[
41.875,
275.625
],
[
63.125,
275.625
],
[
84.375,
275.625
],
[
84.375,
296.875
],
[
63.125,
296.875
],
[
63.125,
318.125
],
[
84.375,
318.125
],
[
84.375,
339.375
],
[
63.125,
339.375
],
[
41.875,
339.375
],
[
41.875,
318.125
],
[
20.625,
318.125
],
[
20.625,
339.375
],
[
20.625,
360.625
],
[
41.875,
360.625
],
[
41.875,
381.875
],
[
20.625,
381.875
],
[
20.625,
403.125
],
[
20.625,
424.375
],
[
41.875,
424.375
],
[
41.875,
403.125
],
[
63.125,
403.125
],
[
63.125,
424.375
],
[
84.375,
424.375
],
[
84.375,
403.125
],
[
84.375,
381.875
],
[
63.125,
381.875
],
[
63.125,
360.625
],
[
84.375,
360.625
],
[
105.625,
360.625
],
[
105.625,
381.875
],
[
126.875,
381.875
],
[
126.875,
360.625
],
[
148.125,
360.625
],
[
169.375,
360.625
],
[
169.375,
381.875
],
[
148.125,
381.875
],
[
148.125,
403.125
],
[
169.375,
403.125
],
[
169.375,
424.375
],
[
148.125,
424.375
],
[
126.875,
424.375
],
[
126.875,
403.125
],
[
105.625,
403.125
],
[
105.625,
424.375
],
[
105.625,
445.625
],
[
105.625,
466.875
],
[
126.875,
466.875
],
[
126.875,
445.625
],
[
148.125,
445.625
],
[
169.375,
445.625
],
[
169.375,
466.875
],
[
148.125,
466.875
],
[
148.125,
488.125
],
[
169.375,
488.125
],
[
169.375,
509.375
],
[
148.125,
509.375
],
[
126.875,
509.375
],
[
126.875,
488.125
],
[
105.625,
488.125
],
[
105.625,
509.375
],
[
84.375,
509.375
],
[
63.125,
509.375
],
[
63.125,
488.125
],
[
84.375,
488.125
],
[
84.375,
466.875
],
[
84.375,
445.625
],
[
63.125,
445.625
],
[
63.125,
466.875
],
[
41.875,
466.875
],
[
41.875,
445.625
],
[
20.625,
445.625
],
[
20.625,
466.875
],
[
20.625,
488.125
],
[
41.875,
488.125
],
[
41.875,
509.375
],
[
20.625,
509.375
],
[
20.625,
530.625
],
[
20.625,
551.875
],
[
41.875,
551.875
],
[
41.875,
530.625
],
[
63.125,
530.625
],
[
84.375,
530.625
],
[
84.375,
551.875
],
[
63.125,
551.875
],
[
63.125,
573.125
],
[
84.375,
573.125
],
[
84.375,
594.375
],
[
63.125,
594.375
],
[
41.875,
594.375
],
[
41.875,
573.125
],
[
20.625,
573.125
],
[
20.625,
594.375
],
[
20.625,
615.625
],
[
41.875,
615.625
],
[
41.875,
636.875
],
[
20.625,
636.875
],
[
20.625,
658.125
],
[
20.625,
679.375
],
[
41.875,
679.375
],
[
41.875,
658.125
],
[
63.125,
658.125
],
[
63.125,
679.375
],
[
84.375,
679.375
],
[
84.375,
658.125
],
[
84.375,
636.875
],
[
63.125,
636.875
],
[
63.125,
615.625
],
[
84.375,
615.625
],
[
105.625,
615.625
],
[
126.875,
615.625
],
[
126.875,
636.875
],
[
105.625,
636.875
],
[
105.625,
658.125
],
[
105.625,
679.375
],
[
126.875,
679.375
],
[
126.875,
658.125
],
[
148.125,
658.125
],
[
148.125,
679.375
],
[
169.375,
679.375
],
[
169.375,
658.125
],
[
169.375,
636.875
],
[
148.125,
636.875
],
[
148.125,
615.625
],
[
169.375,
615.625
],
[
169.375,
594.375
],
[
169.375,
573.125
],
[
148.125,
573.125
],
[
148.125,
594.375
],
[
126.875,
594.375
],
[
105.625,
594.375
],
[
105.625,
573.125
],
[
126.875,
573.125
],
[
126.875,
551.875
],
[
105.625,
551.875
],
[
105.625,
530.625
],
[
126.875,
530.625
],
[
148.125,
530.625
],
[
148.125,
551.875
],
[
169.375,
551.875
],
[
169.375,
530.625
],
[
190.625,
530.625
],
[
190.625,
551.875
],
[
211.875,
551.875
],
[
211.875,
530.625
],
[
233.125,
530.625
],
[
254.375,
530.625
],
[
254.375,
551.875
],
[
233.125,
551.875
],
[
233.125,
573.125
],
[
254.375,
573.125
],
[
254.375,
594.375
],
[
233.125,
594.375
],
[
211.875,
594.375
],
[
211.875,
573.125
],
[
190.625,
573.125
],
[
190.625,
594.375
],
[
190.625,
615.625
],
[
211.875,
615.625
],
[
211.875,
636.875
],
[
190.625,
636.875
],
[
190.625,
658.125
],
[
190.625,
679.375
],
[
211.875,
679.375
],
[
211.875,
658.125
],
[
233.125,
658.125
],
[
233.125,
679.375
],
[
254.375,
679.375
],
[
254.375,
658.125
],
[
254.375,
636.875
],
[
233.125,
636.875
],
[
233.125,
615.625
],
[
254.375,
615.625
],
[
275.625,
615.625
],
[
296.875,
615.625
],
[
296.875,
636.875
],
[
275.625,
636.875
],
[
275.625,
658.125
],
[
275.625,
679.375
],
[
296.875,
679.375
],
[
296.875,
658.125
],
[
318.125,
658.125
],
[
318.125,
679.375
],
[
339.375,
679.375
],
[
339.375,
658.125
],
[
339.375,
636.875
],
[
318.125,
636.875
],
[
318.125,
615.625
],
[
339.375,
615.625
],
[
339.375,
594.375
],
[
339.375,
573.125
],
[
318.125,
573.125
],
[
318.125,
594.375
],
[
296.875,
594.375
],
[
275.625,
594.375
],
[
275.625,
573.125
],
[
296.875,
573.125
],
[
296.875,
551.875
],
[
275.625,
551.875
],
[
275.625,
530.625
],
[
296.875,
530.625
],
[
318.125,
530.625
],
[
318.125,
551.875
],
[
339.375,
551.875
],
[
339.375,
530.625
],
[
339.375,
509.375
],
[
318.125,
509.375
],
[
318.125,
488.125
],
[
339.375,
488.125
],
[
339.375,
466.875
],
[
339.375,
445.625
],
[
318.125,
445.625
],
[
318.125,
466.875
],
[
296.875,
466.875
],
[
296.875,
445.625
],
[
275.625,
445.625
],
[
275.625,
466.875
],
[
275.625,
488.125
],
[
296.875,
488.125
],
[
296.875,
509.375
],
[
275.625,
509.375
],
[
254.375,
509.375
],
[
254.375,
488.125
],
[
233.125,
488.125
],
[
233.125,
509.375
],
[
211.875,
509.375
],
[
190.625,
509.375
],
[
190.625,
488.125
],
[
211.875,
488.125
],
[
211.875,
466.875
],
[
190.625,
466.875
],
[
190.625,
445.625
],
[
211.875,
445.625
],
[
233.125,
445.625
],
[
233.125,
466.875
],
[
254.375,
466.875
],
[
254.375,
445.625
],
[
254.375,
424.375
],
[
254.375,
403.125
],
[
233.125,
403.125
],
[
233.125,
424.375
],
[
211.875,
424.375
],
[
190.625,
424.375
],
[
190.625,
403.125
],
[
211.875,
403.125
],
[
211.875,
381.875
],
[
190.625,
381.875
],
[
190.625,
360.625
],
[
211.875,
360.625
],
[
233.125,
360.625
],
[
233.125,
381.875
],
[
254.375,
381.875
],
[
254.375,
360.625
],
[
275.625,
360.625
],
[
296.875,
360.625
],
[
296.875,
381.875
],
[
275.625,
381.875
],
[
275.625,
403.125
],
[
275.625,
424.375
],
[
296.875,
424.375
],
[
296.875,
403.125
],
[
318.125,
403.125
],
[
318.125,
424.375
],
[
339.375,
424.375
],
[
339.375,
403.125
],
[
339.375,
381.875
],
[
318.125,
381.875
],
[
318.125,
360.625
],
[
339.375,
360.625
],
[
360.625,
360.625
],
[
381.875,
360.625
],
[
381.875,
381.875
],
[
360.625,
381.875
],
[
360.625,
403.125
],
[
360.625,
424.375
],
[
381.875,
424.375
],
[
381.875,
403.125
],
[
403.125,
403.125
],
[
403.125,
424.375
],
[
424.375,
424.375
],
[
424.375,
403.125
],
[
424.375,
381.875
],
[
403.125,
381.875
],
[
403.125,
360.625
],
[
424.375,
360.625
],
[
445.625,
360.625
],
[
445.625,
381.875
],
[
466.875,
381.875
],
[
466.875,
360.625
],
[
488.125,
360.625
],
[
509.375,
360.625
],
[
509.375,
381.875
],
[
488.125,
381.875
],
[
488.125,
403.125
],
[
509.375,
403.125
],
[
509.375,
424.375
],
[
488.125,
424.375
],
[
466.875,
424.375
],
[
466.875,
403.125
],
[
445.625,
403.125
],
[
445.625,
424.375
],
[
445.625,
445.625
],
[
445.625,
466.875
],
[
466.875,
466.875
],
[
466.875,
445.625
],
[
488.125,
445.625
],
[
509.375,
445.625
],
[
509.375,
466.875
],
[
488.125,
466.875
],
[
488.125,
488.125
],
[
509.375,
488.125
],
[
509.375,
509.375
],
[
488.125,
509.375
],
[
466.875,
509.375
],
[
466.875,
488.125
],
[
445.625,
488.125
],
[
445.625,
509.375
],
[
424.375,
509.375
],
[
403.125,
509.375
],
[
403.125,
488.125
],
[
424.375,
488.125
],
[
424.375,
466.875
],
[
424.375,
445.625
],
[
403.125,
445.625
],
[
403.125,
466.875
],
[
381.875,
466.875
],
[
381.875,
445.625
],
[
360.625,
445.625
],
[
360.625,
466.875
],
[
360.625,
488.125
],
[
381.875,
488.125
],
[
381.875,
509.375
],
[
360.625,
509.375
],
[
360.625,
530.625
],
[
360.625,
551.875
],
[
381.875,
551.875
],
[
381.875,
530.625
],
[
403.125,
530.625
],
[
424.375,
530.625
],
[
424.375,
551.875
],
[
403.125,
551.875
],
[
403.125,
573.125
],
[
424.375,
573.125
],
[
424.375,
594.375
],
[
403.125,
594.375
],
[
381.875,
594.375
],
[
381.875,
573.125
],
[
360.625,
573.125
],
[
360.625,
594.375
],
[
360.625,
615.625
],
[
381.875,
615.625
],
[
381.875,
636.875
],
[
360.625,
636.875
],
[
360.625,
658.125
],
[
360.625,
679.375
],
[
381.875,
679.375
],
[
381.875,
658.125
],
[
403.125,
658.125
],
[
403.125,
679.375
],
[
424.375,
679.375
],
[
424.375,
658.125
],
[
424.375,
636.875
],
[
403.125,
636.875
],
[
403.125,
615.625
],
[
424.375,
615.625
],
[
445.625,
615.625
],
[
466.875,
615.625
],
[
466.875,
636.875
],
[
445.625,
636.875
],
[
445.625,
658.125
],
[
445.625,
679.375
],
[
466.875,
679.375
],
[
466.875,
658.125
],
[
488.125,
658.125
],
[
488.125,
679.375
],
[
509.375,
679.375
],
[
509.375,
658.125
],
[
509.375,
636.875
],
[
488.125,
636.875
],
[
488.125,
615.625
],
[
509.375,
615.625
],
[
509.375,
594.375
],
[
509.375,
573.125
],
[
488.125,
573.125
],
[
488.125,
594.375
],
[
466.875,
594.375
],
[
445.625,
594.375
],
[
445.625,
573.125
],
[
466.875,
573.125
],
[
466.875,
551.875
],
[
445.625,
551.875
],
[
445.625,
530.625
],
[
466.875,
530.625
],
[
488.125,
530.625
],
[
488.125,
551.875
],
[
509.375,
551.875
],
[
509.375,
530.625
],
[
530.625,
530.625
],
[
530.625,
551.875
],
[
551.875,
551.875
],
[
551.875,
530.625
],
[
573.125,
530.625
],
[
594.375,
530.625
],
[
594.375,
551.875
],
[
573.125,
551.875
],
[
573.125,
573.125
],
[
594.375,
573.125
],
[
594.375,
594.375
],
[
573.125,
594.375
],
[
551.875,
594.375
],
[
551.875,
573.125
],
[
530.625,
573.125
],
[
530.625,
594.375
],
[
530.625,
615.625
],
[
551.875,
615.625
],
[
551.875,
636.875
],
[
530.625,
636.875
],
[
530.625,
658.125
],
[
530.625,
679.375
],
[
551.875,
679.375
],
[
551.875,
658.125
],
[
573.125,
658.125
],
[
573.125,
679.375
],
[
594.375,
679.375
],
[
594.375,
658.125
],
[
594.375,
636.875
],
[
573.125,
636.875
],
[
573.125,
615.625
],
[
594.375,
615.625
],
[
615.625,
615.625
],
[
636.875,
615.625
],
[
636.875,
636.875
],
[
615.625,
636.875
],
[
615.625,
658.125
],
[
615.625,
679.375
],
[
636.875,
679.375
],
[
636.875,
658.125
],
[
658.125,
658.125
],
[
658.125,
679.375
],
[
679.375,
679.375
],
[
679.375,
658.125
],
[
679.375,
636.875
],
[
658.125,
636.875
],
[
658.125,
615.625
],
[
679.375,
615.625
],
[
679.375,
594.375
],
[
679.375,
573.125
],
[
658.125,
573.125
],
[
658.125,
594.375
],
[
636.875,
594.375
],
[
615.625,
594.375
],
[
615.625,
573.125
],
[
636.875,
573.125
],
[
636.875,
551.875
],
[
615.625,
551.875
],
[
615.625,
530.625
],
[
636.875,
530.625
],
[
658.125,
530.625
],
[
658.125,
551.875
],
[
679.375,
551.875
],
[
679.375,
530.625
],
[
679.375,
509.375
],
[
658.125,
509.375
],
[
658.125,
488.125
],
[
679.375,
488.125
],
[
679.375,
466.875
],
[
679.375,
445.625
],
[
658.125,
445.625
],
[
658.125,
466.875
],
[
636.875,
466.875
],
[
636.875,
445.625
],
[
615.625,
445.625
],
[
615.625,
466.875
],
[
615.625,
488.125
],
[
636.875,
488.125
],
[
636.875,
509.375
],
[
615.625,
509.375
],
[
594.375,
509.375
],
[
594.375,
488.125
],
[
573.125,
488.125
],
[
573.125,
509.375
],
[
551.875,
509.375
],
[
530.625,
509.375
],
[
530.625,
488.125
],
[
551.875,
488.125
],
[
551.875,
466.875
],
[
530.625,
466.875
],
[
530.625,
445.625
],
[
551.875,
445.625
],
[
573.125,
445.625
],
[
573.125,
466.875
],
[
594.375,
466.875
],
[
594.375,
445.625
],
[
594.375,
424.375
],
[
594.375,
403.125
],
[
573.125,
403.125
],
[
573.125,
424.375
],
[
551.875,
424.375
],
[
530.625,
424.375
],
[
530.625,
403.125
],
[
551.875,
403.125
],
[
551.875,
381.875
],
[
530.625,
381.875
],
[
530.625,
360.625
],
[
551.875,
360.625
],
[
573.125,
360.625
],
[
573.125,
381.875
],
[
594.375,
381.875
],
[
594.375,
360.625
],
[
615.625,
360.625
],
[
636.875,
360.625
],
[
636.875,
381.875
],
[
615.625,
381.875
],
[
615.625,
403.125
],
[
615.625,
424.375
],
[
636.875,
424.375
],
[
636.875,
403.125
],
[
658.125,
403.125
],
[
658.125,
424.375
],
[
679.375,
424.375
],
[
679.375,
403.125
],
[
679.375,
381.875
],
[
658.125,
381.875
],
[
658.125,
360.625
],
[
679.375,
360.625
],
[
679.375,
339.375
],
[
679.375,
318.125
],
[
658.125,
318.125
],
[
658.125,
339.375
],
[
636.875,
339.375
],
[
615.625,
339.375
],
[
615.625,
318.125
],
[
636.875,
318.125
],
[
636.875,
296.875
],
[
615.625,
296.875
],
[
615.625,
275.625
],
[
636.875,
275.625
],
[
658.125,
275.625
],
[
658.125,
296.875
],
[
679.375,
296.875
],
[
679.375,
275.625
],
[
679.375,
254.375
],
[
658.125,
254.375
],
[
658.125,
233.125
],
[
679.375,
233.125
],
[
679.375,
211.875
],
[
679.375,
190.625
],
[
658.125,
190.625
],
[
658.125,
211.875
],
[
636.875,
211.875
],
[
636.875,
190.625
],
[
615.625,
190.625
],
[
615.625,
211.875
],
[
615.625,
233.125
],
[
636.875,
233.125
],
[
636.875,
254.375
],
[
615.625,
254.375
],
[
594.375,
254.375
],
[
573.125,
254.375
],
[
573.125,
233.125
],
[
594.375,
233.125
],
[
594.375,
211.875
],
[
594.375,
190.625
],
[
573.125,
190.625
],
[
573.125,
211.875
],
[
551.875,
211.875
],
[
551.875,
190.625
],
[
530.625,
190.625
],
[
530.625,
211.875
],
[
530.625,
233.125
],
[
551.875,
233.125
],
[
551.875,
254.375
],
[
530.625,
254.375
],
[
530.625,
275.625
],
[
530.625,
296.875
],
[
551.875,
296.875
],
[
551.875,
275.625
],
[
573.125,
275.625
],
[
594.375,
275.625
],
[
594.375,
296.875
],
[
573.125,
296.875
],
[
573.125,
318.125
],
[
594.375,
318.125
],
[
594.375,
339.375
],
[
573.125,
339.375
],
[
551.875,
339.375
],
[
551.875,
318.125
],
[
530.625,
318.125
],
[
530.625,
339.375
],
[
509.375,
339.375
],
[
488.125,
339.375
],
[
488.125,
318.125
],
[
509.375,
318.125
],
[
509.375,
296.875
],
[
509.375,
275.625
],
[
488.125,
275.625
],
[
488.125,
296.875
],
[
466.875,
296.875
],
[
466.875,
275.625
],
[
445.625,
275.625
],
[
445.625,
296.875
],
[
445.625,
318.125
],
[
466.875,
318.125
],
[
466.875,
339.375
],
[
445.625,
339.375
],
[
424.375,
339.375
],
[
424.375,
318.125
],
[
403.125,
318.125
],
[
403.125,
339.375
],
[
381.875,
339.375
],
[
360.625,
339.375
],
[
360.625,
318.125
],
[
381.875,
318.125
],
[
381.875,
296.875
],
[
360.625,
296.875
],
[
360.625,
275.625
],
[
381.875,
275.625
],
[
403.125,
275.625
],
[
403.125,
296.875
],
[
424.375,
296.875
],
[
424.375,
275.625
],
[
424.375,
254.375
],
[
424.375,
233.125
],
[
403.125,
233.125
],
[
403.125,
254.375
],
[
381.875,
254.375
],
[
360.625,
254.375
],
[
360.625,
233.125
],
[
381.875,
233.125
],
[
381.875,
211.875
],
[
360.625,
211.875
],
[
360.625,
190.625
],
[
381.875,
190.625
],
[
403.125,
190.625
],
[
403.125,
211.875
],
[
424.375,
211.875
],
[
424.375,
190.625
],
[
445.625,
190.625
],
[
466.875,
190.625
],
[
466.875,
211.875
],
[
445.625,
211.875
],
[
445.625,
233.125
],
[
445.625,
254.375
],
[
466.875,
254.375
],
[
466.875,
233.125
],
[
488.125,
233.125
],
[
488.125,
254.375
],
[
509.375,
254.375
],
[
509.375,
233.125
],
[
509.375,
211.875
],
[
488.125,
211.875
],
[
488.125,
190.625
],
[
509.375,
190.625
],
[
509.375,
169.375
],
[
488.125,
169.375
],
[
488.125,
148.125
],
[
509.375,
148.125
],
[
509.375,
126.875
],
[
509.375,
105.625
],
[
488.125,
105.625
],
[
488.125,
126.875
],
[
466.875,
126.875
],
[
466.875,
105.625
],
[
445.625,
105.625
],
[
445.625,
126.875
],
[
445.625,
148.125
],
[
466.875,
148.125
],
[
466.875,
169.375
],
[
445.625,
169.375
],
[
424.375,
169.375
],
[
424.375,
148.125
],
[
403.125,
148.125
],
[
403.125,
169.375
],
[
381.875,
169.375
],
[
360.625,
169.375
],
[
360.625,
148.125
],
[
381.875,
148.125
],
[
381.875,
126.875
],
[
360.625,
126.875
],
[
360.625,
105.625
],
[
381.875,
105.625
],
[
403.125,
105.625
],
[
403.125,
126.875
],
[
424.375,
126.875
],
[
424.375,
105.625
],
[
424.375,
84.375
],
[
424.375,
63.125
],
[
403.125,
63.125
],
[
403.125,
84.375
],
[
381.875,
84.375
],
[
360.625,
84.375
],
[
360.625,
63.125
],
[
381.875,
63.125
],
[
381.875,
41.875
],
[
360.625,
41.875
],
[
360.625,
20.625
],
[
381.875,
20.625
],
[
403.125,
20.625
],
[
403.125,
41.875
],
[
424.375,
41.875
],
[
424.375,
20.625
],
[
445.625,
20.625
],
[
466.875,
20.625
],
[
466.875,
41.875
],
[
445.625,
41.875
],
[
445.625,
63.125
],
[
445.625,
84.375
],
[
466.875,
84.375
],
[
466.875,
63.125
],
[
488.125,
63.125
],
[
488.125,
84.375
],
[
509.375,
84.375
],
[
509.375,
63.125
],
[
509.375,
41.875
],
[
488.125,
41.875
],
[
488.125,
20.625
],
[
509.375,
20.625
],
[
530.625,
20.625
],
[
530.625,
41.875
],
[
551.875,
41.875
],
[
551.875,
20.625
],
[
573.125,
20.625
],
[
594.375,
20.625
],
[
594.375,
41.875
],
[
573.125,
41.875
],
[
573.125,
63.125
],
[
594.375,
63.125
],
[
594.375,
84.375
],
[
573.125,
84.375
],
[
551.875,
84.375
],
[
551.875,
63.125
],
[
530.625,
63.125
],
[
530.625,
84.375
],
[
530.625,
105.625
],
[
551.875,
105.625
],
[
551.875,
126.875
],
[
530.625,
126.875
],
[
530.625,
148.125
],
[
530.625,
169.375
],
[
551.875,
169.375
],
[
551.875,
148.125
],
[
573.125,
148.125
],
[
573.125,
169.375
],
[
594.375,
169.375
],
[
594.375,
148.125
],
[
594.375,
126.875
],
[
573.125,
126.875
],
[
573.125,
105.625
],
[
594.375,
105.625
],
[
615.625,
105.625
],
[
636.875,
105.625
],
[
636.875,
126.875
],
[
615.625,
126.875
],
[
615.625,
148.125
],
[
615.625,
169.375
],
[
636.875,
169.375
],
[
636.875,
148.125
],
[
658.125,
148.125
],
[
658.125,
169.375
],
[
679.375,
169.375
],
[
679.375,
148.125
],
[
679.375,
126.875
],
[
658.125,
126.875
],
[
658.125,
105.625
],
[
679.375,
105.625
],
[
679.375,
84.375
],
[
679.375,
63.125
],
[
658.125,
63.125
],
[
658.125,
84.375
],
[
636.875,
84.375
],
[
615.625,
84.375
],
[
615.625,
63.125
],
[
636.875,
63.125
],
[
636.875,
41.875
],
[
615.625,
41.875
],
[
615.625,
20.625
],
[
636.875,
20.625
],
[
658.125,
20.625
],
[
658.125,
41.875
],
[
679.375,
41.875
],
[
679.375,
20.625
]
];


//width of path
R = 18 / 2;
R2 = R + 2;

//initial height
H0 = 14;

//slope of ramp
kH = 2;

L = 62;
//L = 30;

make(p);

module make(p) {
  h = 0;
  h0 = 0;

  difference() {

    off = 22;
    end = 148;
    p0 = p[0][0]-off;
    p1 = p[0][1];

    //ramp base
    union() {
      for (i = [0 : 1 : L]) {
        h = kH * i + H0 + 2;
        linear_extrude(height = h) segment(p[i][0], p[i][1], p[i + 1][0], p[i + 1][1], R2);

      }

      linear_extrude(H0) segment(p[0][0], p1, p0, p1, R2);
      linear_extrude(H0-2) segment(p0, p1, p0, p1+end, R2);
    }

    //carving the cylindrical slide
    union() {
      for (j = [0 : 1 : L]) {
        h0 = kH * j + H0 - 1;

        bar(
        p[j][0],
        p[j][1],
        h0,
        p[j + 1][0],
        p[j + 1][1],
        kH * (j + 1) + H0 - 1,
        R + 0.2,
        R + 0.2,
        j == 0);

        slope(
        p[j][0],
        p[j][1],
        h0,
        p[j + 1][0],
        p[j + 1][1],
        kH * (j + 1) + H0 - 1,
        R2 + 0.2,
        R2 + 0.2,
        j == 0);
      }

      bar(p[0][0], p1, H0-1, p0, p1, H0-1.75, R+0.2, R+0.2);
      slope(p[0][0], p1, H0-1, p0, p1, H0-1.75, R2+0.2, R2+0.2);
      bar(p0, p1, H0-2, p0, p1+end, H0-2.5, R+0.2, R+0.2);
      slope(p0, p1, H0-2, p0, p1+end, H0-2.5, R2+0.2, R2+0.2);
    }
  }
}

module segment(x0, y0, x1, y1, r) {
  dx = x1 - x0;
  dy = y1 - y0;
  l = sqrt(dx * dx + dy * dy);
  a = atan2(dy, dx);
  translate([x0, y0, 0]) rotate([0, 0, a]) translate([0, - r, 0]) square([l, r * 2], center = false);
  translate([x0, y0, 0]) circle(r = r);
  translate([x1, y1, 0]) circle(r = r);
}

module bar(x0, y0, z0, x1, y1, z1, rBar, rSphere, sphereInit) {
  x = x1 - x0; y = y1 - y0; z = z1 - z0;

  length = norm([x, y, z]);  // radial distance
  b = acos(z / length); // inclination angle
  c = atan2(y, x);     // azimuthal angle

  translate([x0, y0, z0])
    rotate([0, b, c])
      cylinder(h = length, r = rBar);
  if (sphereInit) translate([x0, y0, z0]) sphere(r = rSphere);
  translate([x1, y1, z1]) sphere(r = rSphere);
}

module slope(x0, y0, z0, x1, y1, z1, rBar, rSphere, sphereInit) {
  x = x1 - x0; y = y1 - y0; z = z1 - z0;

  length = norm([x, y, z]);  // radial distance
  b = acos(z / length); // inclination angle
  c = atan2(y, x);     // azimuthal angle

  extrudeUp()
  translate([x0, y0, z0]) rotate([0, b, c]) flatCube(length, rBar);
  extrudeUp()
  if (sphereInit) translate([x0, y0, z0]) rotate([0, 0, - c]) flatStep(r = rSphere);
  extrudeUp()
  translate([x1, y1, z1]) rotate([0, 0, c]) flatSphere(r = rSphere, flip = c > 90);
}

module flatSphere(r, flip) {
  color("SandyBrown") {
    scale([1, 1, 0.001]) right_half() sphere(r);
  }
}

module flatStep(r) {
  color("Brown") {
    scale([1, 1, 0.001]) right_half() sphere(r);
  }
}

module flatCube(l, w) {
  translate([0, - w, 0]) cube([0.001, w * 2, l]);
}

module extrudeUp() {
  hull() {
    translate([0, 0, 5]) children();
    children();
  }
}
