import { createRoot } from 'react-dom/client';
import './index.css';
import App from './App';

const EXPORT_MODE = process.env.REACT_APP_EXPORT_MODE === "true";
// const root = ReactDOM.createRoot(
//   document.getElementById('root') as HTMLElement
// );
// root.render(
//   <React.StrictMode>
//     <App exportMode={EXPORT_MODE} />
//   </React.StrictMode>
// );

const root = document.getElementById("root");
createRoot(root!).render(
  <App exportMode={EXPORT_MODE} />
);
