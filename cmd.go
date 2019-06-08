package gonutclient

import "fmt"
import "bufio"
import "errors"
import "strings"

func (conn *Conn) Command(input string) (string, error) {
  fmt.Fprintf(conn.TCPConn, "%s\r\n", input)
  output, err := bufio.NewReader(conn.TCPConn).ReadString('\n')
    if err != nil {
      return "", err
    }
    return strings.TrimSuffix(output, "\n"), nil
}

func (conn *Conn) CommandExpect(input, expected string) (string, error) {
  result, err := conn.Command(input)
    if err != nil {
      return result, err
    }
    if result != expected {
      return "", errors.New("Expected " + expected + " but server returned: " + result)
    }
    return result, nil
}

func (conn *Conn) GetVar(variable string) (string, error) {
  out, err := conn.Command("GET VAR " + conn.UPSName + " " + variable)
  if err != nil {
    return out, err
  }
  return strings.TrimSuffix(strings.TrimPrefix(strings.Split(out, " ")[3], "\""), "\""), nil
}
