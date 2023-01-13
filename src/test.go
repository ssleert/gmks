package main

import "os"

func main() {
	if len(os.Args) < 2 {
		os.Exit(1)
	}

	print("hello ", os.Args[1], "\n")
}
