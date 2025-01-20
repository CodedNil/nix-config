package main

import (
	"bytes"
    "fmt"
	"log"
	"os"
	"strings"
)

func main() {
	// SetDevTool enables/disables developer mode of Spotify client
	filePath := os.Getenv("HOME") + "/.cache/spotify/offline.bnk"

	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		fmt.Println("Can't find \"offline.bnk\". Try running spotify first.")
		os.Exit(1)
	}

	file, err := os.OpenFile(filePath, os.O_RDWR, 0644)

	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	buf := new(bytes.Buffer)
	buf.ReadFrom(file)
	content := buf.String()
	firstLocation := strings.Index(content, "app-developer")
	firstPatchLocation := int64(firstLocation + 14)

	secondLocation := strings.LastIndex(content, "app-developer")
	secondPatchLocation := int64(secondLocation + 15)

	file.WriteAt([]byte{50}, firstPatchLocation)
	file.WriteAt([]byte{50}, secondPatchLocation)
	fmt.Println("Enabled DevTools!")
}