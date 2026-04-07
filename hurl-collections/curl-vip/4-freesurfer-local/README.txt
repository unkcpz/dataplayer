First upload local files on VIP

Download test files
wget https://www.creatis.insa-lyon.fr/~abonnet/brain.nii.gz
get freesurfer (free) license file and name it "license.txt"

Then launch
(It is better to delete afterwards)

../createDir.sh /vip/Home/test-eosc
../upload.sh /vip/Home/test-eosc/brain.nii.gz brain.nii.gz
../upload.sh /vip/Home/test-eosc/license.txt license.txt
../init-execution.sh freesurfer-local.json
