import './App.css';
import { Forum } from './components/Forum';

type AppProps = {
  exportMode: boolean;
};

function App({ exportMode: isExport }: AppProps) {
  return (
    <div className="App">
      <header className="App-header">
        <img className="App-logo" alt="logo" />
      </header>
      <Forum/>
    </div>
  );
}

export default App;
