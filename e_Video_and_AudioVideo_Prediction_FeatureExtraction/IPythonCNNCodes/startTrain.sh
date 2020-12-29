echo Training Started!
echo "Using solver: a_solver_audio.prototxt"
"$CAFFE_HOME/build/tools/caffe" train -solver a_solver_audio.prototxt 2>&1 | tee -a outputlogfile_audio.txt
