# https://makefiletutorial.com/

run_stub:
	bash ./data/mock_data/generate_mock_data.sh && \
    nextflow run main.nf -profile stub -stub-run

run_local:
	nextflow run main.nf -profile standard -resume -with-tower
