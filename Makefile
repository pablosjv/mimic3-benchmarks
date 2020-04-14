.PHONY: build run-it extract-subjects validate-events extract-episodes split-train-test reate-los

# all: build extract-subjects validate-events extract-episodes split-train-test create-los
all: build extract-subjects validate-events extract-episodes

build:
	docker build -t mimic .

run-it:
	docker run --rm -it -v $(shell pwd):/src/ -v ${MIMIC_DATA_PATH}:/data mimic bash

extract-subjects:
	docker run --rm -it -v $(shell pwd):/src/ -v ${MIMIC_DATA_PATH}:/data mimic python -m mimic3benchmark.scripts.extract_subjects /data/ data/root/

validate-events:
	docker run --rm -it -v $(shell pwd):/src/ -v ${MIMIC_DATA_PATH}:/data mimic python -m mimic3benchmark.scripts.validate_events data/root/

extract-episodes:
	docker run --rm -it -v $(shell pwd):/src/ -v ${MIMIC_DATA_PATH}:/data mimic python -m mimic3benchmark.scripts.extract_episodes_from_subjects data/root/

split-train-test:
	docker run --rm -it -v $(shell pwd):/src/ -v ${MIMIC_DATA_PATH}:/data mimic python -m mimic3benchmark.scripts.split_train_and_test data/root/

create-los:
	docker run --rm -it -v $(shell pwd):/src/ -v ${MIMIC_DATA_PATH}:/data mimic python -m mimic3benchmark.scripts.create_length_of_stay data/root/ data/length-of-stay/
