import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import {Tab, Tabs} from 'react-bootstrap';
import { Forum } from './components/Forum';
import { Review } from './components/Review';

type AppProps = {
  exportMode: boolean;
};

function App({ exportMode: isExport }: AppProps) {
  return (
    <div className="App">
      <header className="App-header">
        <Tabs>
          <Tab eventKey="website" title="Website"><Review/></Tab>
          <Tab eventKey="forum" title="Forum">    <Forum/> </Tab>
        </Tabs>
      </header>
    </div>
  );
}

export default App;
