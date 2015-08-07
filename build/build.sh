#!/bin/sh

mxmlc -compiler.source-path=./src -static-link-runtime-shared-libraries=true ./src/fm/wavesurfer/WaveSurfer.as -output ./dist/wavesurfer.swf