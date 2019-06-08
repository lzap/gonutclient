package gonutclient

import "testing"

func TestGetLoad(t *testing.T) {
	c := New("localhost:3493", "monuser", "pass", "eaton3s")
	c.Open()
	defer c.Close()
	result, err := c.GetVar("ups.load")
	if (err != nil) {
		t.Errorf("get variable call returned error: %s", err)
	}
	if (result != "30") {
		t.Errorf("ups.load is %s; expected number 0-100", result)
	}
}
