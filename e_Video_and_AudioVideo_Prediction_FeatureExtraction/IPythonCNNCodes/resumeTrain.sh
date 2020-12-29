echo Training Restarted!
echo "Using solver: a_solver.prototxt"
"$CAFFE_HOME/build/tools/caffe" train -solver a_solver.prototxt -snapshot outputModel_iter_14000.solverstate 2>&1 | tee -a outputlogfile_14000.txt
