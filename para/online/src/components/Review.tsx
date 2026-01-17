import { Breadcrumb, Badge, Card } from 'react-bootstrap';

export function Review() {
  return <div className="web-container">
    <TopContent/>
    <Article/>
    <EndContent/>
    </div>;
}

function TopContent(){
    return <div className='top'><Badge bg="warning" text="dark">Header stuff</Badge><br/>
    <Breadcrumb>
      <Breadcrumb.Item> Home </Breadcrumb.Item>
      <Breadcrumb.Item> ... </Breadcrumb.Item>
      <Breadcrumb.Item> Bread </Breadcrumb.Item>
      <Breadcrumb.Item active>Crumbs</Breadcrumb.Item>
    </Breadcrumb>
    </div>
}

function Article() {
    return <div className='article'>
        <h1    className='title'> Review Title </h1>
        <h4 className='subtitle'> And Subtitle </h4>
        <Badge bg="warning" text="dark" className='badge-cat'>New</Badge>
        <Badge bg="warning" text="dark" className='badge-cat'>Review</Badge>
        <em className='by'>By Author at Time</em>
        <div className="review-body">
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin nisl ante, tempus sit amet augue quis, sagittis venenatis massa. Vestibulum consequat, justo in imperdiet fermentum, libero neque tempus ex, eu ornare augue augue ut ipsum. Curabitur sodales id mauris et dictum. Ut ultricies ac felis nec tempus. Quisque rutrum et nisl vel tincidunt. Pellentesque condimentum, nisl a porta aliquet, nulla nisi interdum justo, a pellentesque nibh lectus id odio. Etiam vulputate turpis nec libero hendrerit, eu semper ligula consequat. Suspendisse bibendum justo quis magna vehicula tempus.</p>
            <p>Mauris sagittis, libero ut sagittis auctor, purus velit malesuada augue, nec accumsan diam elit quis neque. Quisque in pharetra lectus, a maximus velit. Praesent sed nisl ullamcorper, imperdiet erat a, interdum mauris. Ut fermentum elit ac enim elementum vehicula. Morbi eu tortor erat. Mauris et posuere metus, sed gravida nibh. Duis viverra ultricies faucibus. Donec finibus massa sed enim scelerisque pellentesque. Curabitur vestibulum elit eget nibh tempor posuere. Cras quis purus at felis sagittis auctor. Nulla venenatis quis enim sit amet fringilla. Integer id neque eleifend, viverra dolor nec, malesuada lacus. Praesent ultrices auctor faucibus. Nulla facilisi.</p>
            <p>Nunc tristique arcu in ex dignissim, in fermentum est ultrices. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse aliquet risus tincidunt accumsan volutpat. Integer quis lorem accumsan, auctor tortor ut, facilisis libero. Etiam placerat odio ac elit vehicula, eget egestas erat sodales. Phasellus nisi risus, venenatis vitae congue non, vestibulum sit amet diam. Quisque malesuada dictum massa non finibus. Morbi placerat sagittis enim mattis finibus.</p>
            <p>Duis maximus tincidunt nunc, ac faucibus nibh fermentum sit amet. Quisque sed luctus risus, et semper erat. Nullam porttitor odio vel dapibus efficitur. Proin magna ligula, iaculis eget malesuada sit amet, facilisis sit amet ligula. Donec pharetra nulla eros, et commodo mauris congue et. Vivamus congue elit lorem, vitae convallis neque blandit nec. Cras venenatis vestibulum mi, tristique mattis risus fermentum eu. Duis sed elit at dui suscipit sagittis. Cras interdum tempus est nec scelerisque. Maecenas iaculis semper bibendum. Etiam sollicitudin blandit lacus in dignissim.</p>
        </div>
    </div>
}

function EndContent() {
    return <div className='end'>
        <div className='tags'>
            <Badge pill bg="info" className='badge-tag'>Tag</Badge>
            <Badge pill bg="info" className='badge-tag'>Tag</Badge>
            <Badge pill bg="info" className='badge-tag'>Tag</Badge>
            <Badge pill bg="info" className='badge-tag'>Tag</Badge>
            <Badge pill bg="info" className='badge-tag'>Tag</Badge>
            <Badge pill bg="info" className='badge-tag'>Tag</Badge>
            <Badge pill bg="info" className='badge-tag'>Tag</Badge>
            <Badge pill bg="info" className='badge-tag'>Tag</Badge>
        </div>
        <Card border="success" className='about'>
            <Card.Header>Featured</Card.Header>
            <Card.Body>
                <Card.Title>Card Title</Card.Title>
                <Card.Subtitle className="mb-2 text-muted">Card Subtitle</Card.Subtitle>
                <Card.Text>
                    Some quick example text to build on the card title and make up the bulk of the card's content.
                </Card.Text>
            </Card.Body>
            <Card.Footer className="text-muted">2 days ago</Card.Footer>
        </Card>
    </div>
}