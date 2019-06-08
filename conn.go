package gonutclient

import "net"

type Conn struct {
	Host string
	User, Pass string
	UPSName string
	TCPConn net.Conn
}

func New(host, user, pass, upsName string) *Conn {
	return &Conn{host, user, pass, upsName, nil}
}

func (conn *Conn) Open() error {
	dialedConn, err := net.Dial("tcp", conn.Host)
    if err != nil {
    	return err
    }
    conn.TCPConn = dialedConn
	conn.CommandExpect("USERNAME " + conn.User, "OK")
	conn.CommandExpect("PASSWORD " + conn.Pass, "OK")
	conn.CommandExpect("LOGIN " + conn.UPSName, "OK")
	return nil
}

func (conn *Conn) Close() {
	if (conn.TCPConn != nil) {
		conn.TCPConn.Close()
	}
	conn.TCPConn = nil
}

