build: test
	go build .

.PHONY: test
test: 
	go test -v -count 1 -race .
	go install .
	go vet .
	test -z $$(gofmt -s -l . | tee /dev/stderr)

.PHONY: clean
clean:
	rm main go.sum
