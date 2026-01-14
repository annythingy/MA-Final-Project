import React, { JSX } from 'react';
import threads from '../threads-data.json';

type ThreadProps = {
  title: string,
  username: string,
  description: string,
  date: string,
  comments: CommentProps[]
}

type CommentProps = {
  username: string,
  date: string,
  content: string
};

type ThreadViewerProps = {
  selectedThread ?: ThreadProps
}

export function Forum() {
  return <div className="forum-container">
      <ThreadsList/>
      {/* <ThreadViewer selectedThread={selectedThread}/> */}
    </div>;
}

function ThreadsList() : JSX.Element {
  const [selectedThread, setSelectedThread] = React.useState<ThreadProps | undefined>();
  const [threadList, setThreadList] = React.useState<ThreadProps[]>(threads as ThreadProps[]);
  return <>
    <div className="threads-list">
      {threadList.map((thread, index) => thread ?
        <><div onClick={()=>setSelectedThread(thread)} className="thread-btn" key={index}>
          <span>
            <i>{thread.date} </i>
            <b>{thread.username}: </b> {thread.title}
          </span>
        </div><br/></>
        :
        (<div key={index}>No thread data</div>
      ))}
    </div>
    <ThreadViewer selectedThread={selectedThread}/>
  </>
}

function ThreadViewer({ selectedThread }: ThreadViewerProps) : JSX.Element {
  return <div className="thread-viewer">
    {selectedThread ? 
      <article className="thread">
        <Thread selectedThread={selectedThread} />
        <section className="post">
          {selectedThread.comments.map((comment, index) => (
            <Comment key={index} 
              username={comment.username} 
              date={comment.date} 
              content={comment.content} />
          ))}
        </section>
        <hr/>
      </article>
    :
      <div>
        <h2>Thread Viewer</h2>
        <p>Select a thread to read through its comments.</p>
      </div>}
    </div>
  }

function Thread({selectedThread}: any) {
  return <>
        <h1>{selectedThread.title}</h1>
        <section className="post">
          <header>
            <strong>{selectedThread.username}</strong>
            <em>&nbsp;&nbsp;&nbsp;&nbsp;{selectedThread.date}</em>
          </header>
          <p style={{fontSize: "24px"}}>{selectedThread.description}</p>
        </section>
  </>
}

function Comment({username,date,content}: CommentProps) {
  return (
    <section className="comment"><hr/>
      <header>
        <strong>{username}</strong>
        <time>&nbsp;&nbsp;&nbsp;&nbsp;{date}</time>
      </header>
      <p>{content}</p>
    </section>
  )
}